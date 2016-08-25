package cn.chinuy.ads.providers.material.loader {
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.TimeoutEvent;
	import org.bytearray.gif.player.GIFPlayer;
	
	/**
	 * @author chin
	 */
	public class GIFLoader extends UIContainer implements IMaterialLoader {
		
		private var _url : String;
		private var _ready : Boolean;
		private var _originalWidth : Number;
		private var _originalHeight : Number;
		private var loader : GIFPlayer;
		private var holder : Sprite = new Sprite;
		
		public function GIFLoader( url : String = null ) {
			super();
			addChild( holder );
			this.url = url;
		}
		
		public function get url() : String {
			return _url;
		}
		
		public function set url( value : String ) : void {
			var changed : Boolean = url != value;
			if( changed ) {
				removeLoader();
				_url = value;
				_ready = false;
				if( url != null ) {
					loader = new GIFPlayer();
					loader.addEventListener( GIFPlayerEvent.COMPLETE, onLoadComplete );
					loader.addEventListener( FileTypeEvent.INVALID, onParseError );
					loader.addEventListener( TimeoutEvent.TIME_OUT, onParseError );
					loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadError );
					loader.load( new URLRequest( url ));
				}
			}
		}
		
		private function removeLoader() : void {
			removeLoaderEvent();
			if( ready ) {
				holder.removeChild( loader );
			}
		}
		
		private function removeLoaderEvent() : void {
			if( loader ) {
				loader.removeEventListener( GIFPlayerEvent.COMPLETE, onLoadComplete );
				loader.removeEventListener( FileTypeEvent.INVALID, onParseError );
				loader.removeEventListener( TimeoutEvent.TIME_OUT, onParseError );
				loader.removeEventListener( IOErrorEvent.IO_ERROR, onLoadError );
			}
		}
		
		private function updateLoader() : void {
			if( ready ) {
				holder.scaleX = width / originalWidth;
				holder.scaleY = height / originalHeight;
			}
		}
		
		public function get ready() : Boolean {
			return _ready;
		}
		
		public function play() : void {
			loader.gotoAndPlay( 0 );
		}
		
		public function stop() : void {
			loader.stop();
		}
		
		public function get originalWidth() : Number {
			if( ready ) {
				return _originalWidth;
			}
			return -1;
		}
		
		public function get originalHeight() : Number {
			if( ready ) {
				return _originalHeight;
			}
			return -1;
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			updateLoader();
		}
		
		private function onLoadComplete( e : GIFPlayerEvent ) : void {
			removeLoaderEvent();
			addEventListener( Event.ENTER_FRAME, nextFrame );
		}
		
		private function nextFrame( event : Event ) : void {
			_originalWidth = loader.width;
			_originalHeight = loader.height;
			if( _originalWidth > 0 && _originalHeight > 0 ) {
				_ready = true;
				updateLoader();
				holder.addChild( loader );
				dispatchEvent( new Event( Event.COMPLETE ));
			}
		}
		
		private function onParseError( event : Event ) : void {
			removeLoaderEvent();
			dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR ));
		}
		
		private function onLoadError( event : Event ) : void {
			removeLoaderEvent();
			dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR ));
		}
	}
}
