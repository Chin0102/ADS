package cn.chinuy.ads.core.position {
	import cn.chinuy.ads.core.ADManager;
	import cn.chinuy.ads.core.ADRequest;
	import cn.chinuy.ads.core.ad.IAD;
	import cn.chinuy.ads.core.provider.IProvider;
	import cn.chinuy.display.layout.ILayoutElement;
	
	/**
	 * @author chin
	 */
	public interface IPosition extends ILayoutElement {
		function set manager( manager : ADManager ) : void;
		function get manager() : ADManager;
		function get request() : ADRequest;
		function get provider() : IProvider;
		function get ad() : IAD;
		function unload() : void;
		function load( data : ADRequest ) : void;
		function destroy() : void;
	}
}
