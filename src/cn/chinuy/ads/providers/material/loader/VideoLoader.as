package cn.chinuy.ads.providers.material.loader {
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * @author chin
	 */
	public class VideoLoader extends UIContainer implements IMaterialLoader {
		
		private var _url : String;
		private var _nc : NetConnection;
		private var _ns : NetStream;
		private var _ready : Boolean;
		private var _videoWidth : Number;
		private var _videoHeight : Number;
		private var _timeCurrent : Number = 0;
		private var _timeTotal : Number = 0;
		private var loop : Boolean;
		private var video : Video = new Video();
		
		public function VideoLoader( url : String = null, loop : Boolean = false ) {
			super();
			video.smoothing = true;
			addChild( video );
			this.url = url;
			this.loop = loop;
		}
		
		protected function get nc() : NetConnection {
			if( _nc == null ) {
				_nc = new NetConnection();
				_nc.connect( null );
			}
			return _nc;
		}
		
		protected function get ns() : NetStream {
			if( _ns == null ) {
				_ns = new NetStream( nc );
				_ns.client = { onMetaData:onMetaData };
				_ns.addEventListener( NetStatusEvent.NET_STATUS, onNSStatus );
			}
			return _ns;
		}
		
		protected function get hasNS() : Boolean {
			return _ns != null;
		}
		
		public function get ready() : Boolean {
			return _ready;
		}
		
		public function get url() : String {
			return _url;
		}
		
		public function set url( value : String ) : void {
			var changed : Boolean = _url != value;
			if( changed ) {
				_url = value;
				stop();
				if( value != null ) {
					ns.soundTransform = new SoundTransform( 0 );
					ns.play( value );
					video.attachNetStream( ns );
				}
			}
		}
		
		public function get timeCurrent() : Number {
			return _timeCurrent;
		}
		
		public function get timeTotal() : Number {
			return _timeTotal;
		}
		
		public function play() : void {
			if( ready ) {
				ns.soundTransform = new SoundTransform( 1 );
				ns.seek( 0 );
				ns.resume();
			}
		}
		
		public function stop() : void {
			if( hasNS ) {
				ns.close();
			}
			removeEventListener( Event.ENTER_FRAME, onProgress );
			_ready = false;
		}
		
		protected function onMetaData( info : Object ) : void {
			if( !ready ) {
				ns.pause();
				_videoWidth = info[ "width" ];
				_videoHeight = info[ "height" ];
				_timeTotal = info[ "duration" ];
				_timeCurrent = 0;
				_ready = true;
				addEventListener( Event.ENTER_FRAME, onProgress );
				dispatchEvent( new Event( Event.COMPLETE ));
			}
		}
		
		private function onProgress( e : Event ) : void {
			var t : Number = ns.time;
			if( _timeCurrent != t ) {
				_timeCurrent = t;
				var event : ADEvent = new ADEvent( ADEvent.MaterialProgress );
				event.value = { timeCurrent:timeCurrent, timeTotal:timeTotal };
				dispatchEvent( event );
			}
		}
		
		protected function onNSStatus( e : NetStatusEvent ) : void {
			dispatchEvent( e );
			switch( e.info[ "code" ]) {
				case "NetStream.Play.StreamNotFound":
					if( !_ready ) {
						dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR ));
					}
					break;
				case "NetStream.Play.Stop":
					if( loop )
						ns.seek( 0 );
					break;
			}
		}
		
		public function get originalWidth() : Number {
			return _videoWidth;
		}
		
		public function get originalHeight() : Number {
			return _videoHeight;
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			video.width = width;
			video.height = height;
		}
	}
}
