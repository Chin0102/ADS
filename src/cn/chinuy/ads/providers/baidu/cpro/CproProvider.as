package cn.chinuy.ads.providers.baidu.cpro {
	import cn.chinuy.ads.core.provider.Provider;
	
	/**
	 * @author chin
	 */
	public class CproProvider extends Provider {
		
		public static var NAME : String = "baidu";
		
		public function CproProvider() {
			super();
		}
		
		override protected function create() : void {
			var param : CproParam = request.param as CproParam;
			if( param ) {
				setCreateSuccess( new Cpro( param ));
			} else {
				setCreateFailed( "invalid baidu cpro param" );
			}
		}
	}
}
