package cn.chinuy.ads.providers.baidu.cpro {
	import cn.chinuy.ads.core.ad.SWFContainerAD;
	
	import flash.events.Event;
	
	/**
	 * @author Chin
	 */
	public class Cpro extends SWFContainerAD {
		
		private var _param : CproParam;
		
		public function Cpro( param : CproParam ) {
			super();
			left = right = top = bottom = 0;
			_param = param;
		}
		
		public function get param() : CproParam {
			return _param;
		}
		
		override public function display() : void {
			load( "http://cpro.baidu.com/cpro/ui/baiduLoader_as3.swf" );
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			if( swf.valid ) {
				swf.call( "setSize", width, height );
			}
		}
		
		override protected function onSdkLoadSuccess( e : Event ) : void {
			super.onSdkLoadSuccess( e );
			swf.call( "requestAdData", onLoadSuccess, param.value );
		}
		
		protected function onLoadSuccess( e : Event = null ) : void {
			content.addChild( swf.loader );
			setADReady();
		}
	
	}
}

