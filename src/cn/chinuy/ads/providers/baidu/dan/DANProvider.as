package cn.chinuy.ads.providers.baidu.dan {
	import cn.chinuy.ads.core.provider.Provider;
	
	/**
	 * @author Chin
	 */
	public class DANProvider extends Provider {
		
		public static const NAME : String = "baidudan";
		
		public function DANProvider() {
			super();
		}
		
		override protected function create() : void {
			var param : DANParam = request.param as DANParam;
			if( param ) {
				setCreateSuccess( new DAN( param ));
			} else {
				setCreateFailed( "invalid baidu dan param" );
			}
		}
	}
}
