package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.position.IPosition;
	import cn.chinuy.display.uicore.UIContainer;
	
	/**
	 * @author chin
	 */
	public class ADGroup extends UIContainer implements IAD {
		
		private var _position : IPosition;
		protected var group : Array;
		protected var ad : IAD;
		protected var adReady : Boolean;
		
		public function ADGroup( group : Array ) {
			super();
			AD.tile( this );
			this.group = group;
		}
		
		public function get position() : IPosition {
			return _position;
		}
		
		public function click() : void {
			if( ad )
				ad.click();
		}
		
		public function get ready() : Boolean {
			return adReady;
		}
		
		public function get hasTimeline() : Boolean {
			return false;
		}
		
		public function get duration() : IADDuration {
			if( ad )
				return ad.duration;
			return null;
		}
		
		public function set duration( value : IADDuration ) : void {
		}
		
		public function setDuration( timeEnd : int, timeStart : int = 0, duration : int = 0, useADTimeline : Boolean = false ) : void {
		}
		
		public function init( position : IPosition ) : void {
			_position = position;
			onInit();
		}
		
		public function display() : void {
		}
		
		public function destroy() : void {
			while( group.length > 0 ) {
				var ad : IAD = group.shift();
				ad.destroy();
			}
		}
		
		protected function onInit() : void {
		}
	}
}
