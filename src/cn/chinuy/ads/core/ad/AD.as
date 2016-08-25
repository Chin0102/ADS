package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.ads.core.position.IPosition;
	import cn.chinuy.display.layout.ILayoutElement;
	import cn.chinuy.display.uicore.UIContainer;
	
	/**
	 * @author chin
	 */
	public class AD extends UIContainer implements IAD {
		
		private var _content : UIContainer = new UIContainer();
		private var _cover : ADCover = new ADCover();
		private var _scaleMode : String;
		private var _ready : Boolean;
		private var _position : IPosition;
		private var _duration : IADDuration;
		
		public function AD() {
			super();
			_scaleMode = ADScaleMode.FloorSizeAlwaysScale;
			cover.visible = false;
			cover.addEventListener( ADEvent.Click, onClick );
			addChild( content );
			addChild( cover );
		}
		
		public function get content() : UIContainer {
			return _content;
		}
		
		public function get cover() : ADCover {
			return _cover;
		}
		
		public function get position() : IPosition {
			return _position;
		}
		
		public function get hasTimeline() : Boolean {
			return false;
		}
		
		public function get duration() : IADDuration {
			return _duration;
		}
		
		public function set duration( value : IADDuration ) : void {
			_duration = value;
		}
		
		public function setDuration( timeEnd : int, timeStart : int = 0, duration : int = 0, useADTimeline : Boolean = false ) : void {
			if( timeEnd > 0 ) {
				if( useADTimeline ) {
					_duration = new ADDuration( timeEnd, timeStart, duration );
				} else {
					_duration = new TimerDuration( timeEnd, timeStart, duration );
				}
			}
		}
		
		public function click() : void {
			cover.toClick();
		}
		
		public function init( position : IPosition ) : void {
			_position = position;
			onInit();
		}
		
		public function display() : void {
			if( duration )
				duration.start( this );
		}
		
		public function destroy() : void {
		}
		
		public function get ready() : Boolean {
			return _ready;
		}
		
		protected function onInit() : void {
			scaleMode = position.request.scaleMode;
		}
		
		protected function setADFinish( isError : Boolean, msg : String = null ) : void {
			var e : ADEvent = new ADEvent( isError ? ADEvent.Error : ADEvent.Finished );
			e.msg = msg;
			dispatchEvent( e );
		}
		
		protected function setADReady() : void {
			_ready = true;
			sizeRender();
			dispatchEvent( new ADEvent( ADEvent.Ready ));
		}
		
		protected function onClick( e : ADEvent ) : void {
			dispatchEvent( e );
		}
		
		public function get scaleMode() : String {
			return _scaleMode;
		}
		
		public function set scaleMode( value : String ) : void {
			_scaleMode = value;
		}
		
		public static function tile( e : ILayoutElement ) : void {
			e.left = e.right = e.top = e.bottom = 0;
		}
		
		public static function midAlign( e : ILayoutElement, w : Number, h : Number ) : void {
			e.width = w;
			e.height = h;
			e.hcenter = e.vcenter = 0;
			e.left = e.right = e.top = e.bottom = "";
		}
	
	}
}
