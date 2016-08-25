package cn.chinuy.ads.providers.baidu.adm {
	import cn.chinuy.ads.core.provider.Provider;
	import cn.chinuy.ads.providers.material.MaterialAD;
	import cn.chinuy.ads.providers.material.MaterialADParam;
	import cn.chinuy.data.string.toNumber;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	/**
	 * @author chin
	 */
	public class AdmProvider extends Provider {
		
		public static const NAME : String = "baiduadmin";
		
		protected var api : AdmAPI;
		
		public function AdmProvider() {
			super();
		}
		
		override public function destroy() : void {
			if( api ) {
				api.removeEventListener( Event.COMPLETE, onLoadSuccess );
				api.removeEventListener( IOErrorEvent.IO_ERROR, onLoadFaild );
				api.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadFaild );
				api.unload();
			}
		}
		
		override protected function create() : void {
			var param : AdmParam = request.param as AdmParam;
			if( param ) {
				api = new AdmAPI( param );
				api.addEventListener( Event.COMPLETE, onLoadSuccess );
				api.addEventListener( IOErrorEvent.IO_ERROR, onLoadFaild );
				api.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadFaild );
				api.load();
				return;
			}
			setCreateFailed( "invalid baidu adm param" );
		}
		
		protected function onLoadFaild( e : Event ) : void {
			setCreateFailed( "baidu adm api load error" );
		}
		
		protected function onLoadSuccess( e : Event ) : void {
			if( api.hasInfo()) {
				var adInfo : Object = api.info;
				if( adInfo[ "type" ] != "0" ) {
					var w : Number = toNumber( adInfo[ "w" ], NaN, true );
					var h : Number = toNumber( adInfo[ "h" ], NaN, true );
					var materialADParam : MaterialADParam = new MaterialADParam( adInfo[ "m_url" ], adInfo[ "c_url" ], w, h, MaterialAD.IMAGE );
					setCreateSuccess( MaterialAD.create( materialADParam ));
					return;
				}
			}
			setCreateFailed( "baidu adm api returned no ad" );
		}
	
	}
}
