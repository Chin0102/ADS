package cn.chinuy.ads.core.position {
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.ads.core.ADManager;
	import cn.chinuy.ads.core.ADRequest;
	import cn.chinuy.ads.core.ad.IAD;
	import cn.chinuy.ads.core.ad.IADDuration;
	import cn.chinuy.ads.core.provider.IProvider;
	import cn.chinuy.display.uicore.UIContainer;
	
	/**
	 * @author chin
	 */
	public class Position extends UIContainer implements IPosition {
		
		private var _manager : ADManager;
		private var _request : ADRequest;
		private var _provider : IProvider;
		private var _ad : IAD;
		
		public function Position() {
			super();
			visible = false;
			left = right = top = bottom = 0;
		}
		
		public function set manager( manager : ADManager ) : void {
			_manager = manager;
		}
		
		public function get manager() : ADManager {
			return _manager;
		}
		
		public function get request() : ADRequest {
			return _request;
		}
		
		public function get provider() : IProvider {
			return _provider;
		}
		
		public function get ad() : IAD {
			return _ad;
		}
		
		public function get adReady() : Boolean {
			return ad != null && ad.ready;
		}
		
		public function destroy() : void {
			unload();
		}
		
		public function unload() : void {
			if( provider ) {
				setProviderEvent( provider.removeEventListener );
				provider.destroy();
				_provider = null;
			}
			if( ad ) {
				setADEvent( ad.removeEventListener );
				ad.destroy();
				if( this == ad.displayObject.parent ) {
					removeChild( ad.displayObject );
				}
				_ad = null;
			}
			visible = false;
		}
		
		public function load( request : ADRequest ) : void {
			unload();
			visible = true;
			_request = request;
			_provider = manager.getProvider( request.provider );
			if( provider ) {
				onProviderCreateSuccess();
			} else {
				onProviderCreateFailed();
			}
		}
		
		protected function onProviderCreateSuccess() : void {
			setProviderEvent( provider.addEventListener );
			dispatchEvent( new ADEvent( ADEvent.ProviderCreateSuccess ));
			provider.createAD( this, request );
		}
		
		protected function onProviderCreateFailed() : void {
			var e : ADEvent = new ADEvent( ADEvent.ProviderCreateFailed );
			e.msg = request.provider + "provider not found ";
			dispatchEvent( e );
		}
		
		protected function setProviderEvent( func : Function ) : void {
			func( ADEvent.CreateSuccess, onADCreateSuccess );
			func( ADEvent.CreateFailed, onADCreateFailed );
		}
		
		protected function setADEvent( func : Function ) : void {
			func( ADEvent.Ready, onADReady );
			func( ADEvent.Error, onADError );
			func( ADEvent.Click, onADClick );
			func( ADEvent.Progress, onADProgress );
			func( ADEvent.Finished, onADFinished );
		}
		
		protected function onADCreateSuccess( e : ADEvent ) : void {
			_ad = provider.ad;
			dispatchEvent( e );
			addChildAt( ad.displayObject, 0 );
			setADEvent( ad.addEventListener );
			ad.init( this );
		}
		
		protected function onADCreateFailed( e : ADEvent ) : void {
			unload();
			dispatchEvent( e );
		}
		
		protected function onADReady( e : ADEvent ) : void {
			ad.display();
			dispatchEvent( e );
		}
		
		protected function onADFinished( e : ADEvent ) : void {
			unload();
			dispatchEvent( e );
		}
		
		protected function onADError( e : ADEvent ) : void {
			dispatchEvent( e );
		}
		
		protected function onADClick( e : ADEvent ) : void {
			dispatchEvent( e );
		}
		
		private function onADProgress( e : ADEvent ) : void {
			onProgress( ad.duration );
		}
		
		protected function onProgress( duration : IADDuration ) : void {
		}
	
	}
}
