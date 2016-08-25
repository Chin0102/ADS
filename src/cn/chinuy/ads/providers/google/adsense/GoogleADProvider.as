package cn.chinuy.ads.providers.google.adsense {
	import cn.chinuy.ads.core.provider.Provider;
	
	/**
	 * @author Chin
	 */
	public class GoogleADProvider extends Provider {
		
		public static var NAME : String = "google";
		
		public function GoogleADProvider() {
			super();
		}
		
		override protected function create() : void {
			var param : GoogleADParam = request.param as GoogleADParam;
			if( param ) {
				setCreateSuccess( new GoogleAD( param ));
			} else {
				setCreateFailed( "invalid adsense param" );
			}
		}
	}
}
