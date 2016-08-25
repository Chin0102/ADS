package cn.chinuy.ads.providers.baidu.dan {
	
	/**
	 * @author chin
	 */
	public class DANParam {
		
		public var dan_id : String;
		public var dan_w : Number;
		public var dan_h : Number;
		
		public function DANParam( id : String, w : Number, h : Number ) {
			dan_id = id;
			dan_w = w;
			dan_h = h;
		}
		
		public function get value() : Object {
			return { dan_id:dan_id, dan_w:dan_w, dan_h:dan_h };
		}
	}
}
