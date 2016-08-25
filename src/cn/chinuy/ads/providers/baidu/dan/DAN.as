package cn.chinuy.ads.providers.baidu.dan {
	import cn.chinuy.ads.core.ad.SWFContainerAD;
	
	import flash.events.Event;
	
	/**
	 * @author Chin
	 */
	public class DAN extends SWFContainerAD {
		
		private var _param : DANParam;
		
		public function DAN( param : DANParam ) {
			super();
			left = right = top = bottom = 0;
			_param = param;
		}
		
		public function get param() : DANParam {
			return _param;
		}
		
		override public function display() : void {
			load( "http://dn.baidu.com/flash/loader_as3.swf" ); //load("http://bs.baidu.com/loader/loader_as3.swf");//test
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			if( swf.valid ) {
				swf.call( "setSize", width, height );
			}
		}
		
		override protected function onSdkLoadSuccess( e : Event ) : void {
			super.onSdkLoadSuccess( e );
			swf.call( "requestAdData", onLoadSuccess, onLoadError, param.value );
		}
		
		protected function onLoadError( e : Event = null ) : void {
			setADFinish( true );
		}
		
		protected function onLoadSuccess( e : Event = null ) : void {
			content.addChild( swf.loader );
			var d : Number = swf.call( "duration" );
			if( !isNaN( d )) {
				d = swf.getProperty( "duration" );
			}
			if( !isNaN( d )) {
				setDuration( d );
			}
			setADReady();
		}
	}
}
