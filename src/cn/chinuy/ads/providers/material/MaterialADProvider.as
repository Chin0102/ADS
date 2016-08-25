package cn.chinuy.ads.providers.material {
	import cn.chinuy.ads.core.provider.Provider;
	
	/**
	 * @author chin
	 */
	public class MaterialADProvider extends Provider {
		
		public function MaterialADProvider() {
			super();
		}
		
		override protected function create() : void {
			var param : MaterialADParam = MaterialADParam.parse( request.param );
			if( param ) {
				var ad : MaterialAD = MaterialAD.create( param );
				if( ad ) {
					setCreateSuccess( ad );
					return;
				}
			}
			setCreateFailed( "invalid material param" );
		}
	}
}
