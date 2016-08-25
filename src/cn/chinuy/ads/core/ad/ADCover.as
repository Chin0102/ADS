package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * @author chin
	 */
	public class ADCover extends UIContainer {
		
		private var _link : String;
		private var clickLayer : UIContainer;
		
		public function ADCover() {
			super();
			clickLayer = new UIContainer();
			clickLayer.buttonMode = true;
			clickLayer.bgColor = clickLayer.bgAlpha = 0;
			clickLayer.left = clickLayer.right = clickLayer.top = clickLayer.bottom = 0;
			clickLayer.addEventListener( MouseEvent.CLICK, toClick );
			addChild( clickLayer );
		}
		
		public function get link() : String {
			return _link;
		}
		
		public function set link( value : String ) : void {
			_link = value;
		}
		
		public function toClick( event : MouseEvent = null ) : void {
			dispatchEvent( new ADEvent( ADEvent.Click ));
			if( link && link.indexOf( "http" ) == 0 ) {
				navigateToURL( new URLRequest( link ), "_blank" );
			}
		}
	}
}
