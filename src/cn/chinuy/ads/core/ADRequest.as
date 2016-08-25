package cn.chinuy.ads.core {
	import cn.chinuy.ads.core.ad.ADScaleMode;
	
	/**
	 * @author chin
	 */
	public class ADRequest {
		
		public var position : String;
		public var provider : String;
		public var param : *;
		
		//AD Setting
		public var scaleMode : String = ADScaleMode.FloorSizeAlwaysScale;
		public var canClose : Boolean;
		
		public function ADRequest( position : String, provider : String, param : * = null ) {
			this.position = position;
			this.provider = provider;
			this.param = param;
		}
	}
}
