package cn.chinuy.ads.core.provider {
	import cn.chinuy.ads.core.ADManager;
	import cn.chinuy.ads.core.ADRequest;
	import cn.chinuy.ads.core.ad.IAD;
	import cn.chinuy.ads.core.position.IPosition;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface IProvider extends IEventDispatcher {
		function set manager( manager : ADManager ) : void;
		function get manager() : ADManager;
		function get request() : ADRequest;
		function get position() : IPosition;
		function get ad() : IAD;
		function destroy() : void;
		function createAD( position : IPosition, request : ADRequest ) : void;
	}
}
