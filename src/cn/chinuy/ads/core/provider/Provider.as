package cn.chinuy.ads.core.provider {
	
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.ads.core.ADManager;
	import cn.chinuy.ads.core.ADRequest;
	import cn.chinuy.ads.core.ad.IAD;
	import cn.chinuy.ads.core.position.IPosition;
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class Provider extends EventDispatcher implements IProvider {
		
		private var _manager : ADManager;
		private var _request : ADRequest;
		private var _position : IPosition;
		private var _ad : IAD;
		
		public function Provider() {
			super();
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
		
		public function get position() : IPosition {
			return _position;
		}
		
		public function get ad() : IAD {
			return _ad;
		}
		
		public function destroy() : void {
			_ad = null;
			dispatchEvent( new ADEvent( ADEvent.ProviderDestroy ));
		}
		
		public function createAD( position : IPosition, request : ADRequest ) : void {
			_position = position;
			_request = request;
			create();
		}
		
		protected function create() : void {
		}
		
		protected function setCreateSuccess( ad : IAD ) : void {
			_ad = ad;
			dispatchEvent( new ADEvent( ADEvent.CreateSuccess ));
		}
		
		protected function setCreateFailed( msg : String ) : void {
			var e : ADEvent = new ADEvent( ADEvent.CreateFailed );
			e.msg = msg;
			dispatchEvent( e );
		}
	
	}
}
