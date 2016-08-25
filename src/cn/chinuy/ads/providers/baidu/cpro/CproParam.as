package cn.chinuy.ads.providers.baidu.cpro {
	
	/**
	 * @author chin
	 */
	public class CproParam {
		
		public static function getDefault() : CproParam {
			var param : CproParam = new CproParam();
			return param;
		}
		
		private var _value : Object = {};
		
		public function CproParam( value : Object = null ) {
			if( value != null ) {
				this.value = value;
			}
		}
		
		public function set value( value : Object ) : void {
			_value = value;
		}
		
		public function get value() : Object {
			return _value;
		}
		
		public function get cpro_aurl() : String {
			return _value[ "cpro_aurl" ];
		}
		
		public function set cpro_aurl( value : String ) : void {
			_value[ "cpro_aurl" ] = value;
		}
		
		public function get cpro_instead() : Number {
			return _value[ "cpro_instead" ];
		}
		
		public function set cpro_instead( value : Number ) : void {
			_value[ "cpro_instead" ] = value;
		}
		
		public function get cpro_cad() : String {
			return _value[ "cpro_cad" ];
		}
		
		public function set cpro_cad( value : String ) : void {
			_value[ "cpro_cad" ] = value;
		}
		
		public function get cpro_acolor() : Number {
			return _value[ "cpro_acolor" ];
		}
		
		public function set cpro_acolor( value : Number ) : void {
			_value[ "cpro_acolor" ] = value;
		}
		
		public function get cpro_plan() : Number {
			return _value[ "cpro_plan" ];
		}
		
		public function set cpro_plan( value : Number ) : void {
			_value[ "cpro_plan" ] = value;
		}
		
		public function get cpro_h() : Number {
			return _value[ "cpro_h" ];
		}
		
		public function set cpro_h( value : Number ) : void {
			_value[ "cpro_h" ] = value;
		}
		
		public function get cpro_w() : Number {
			return _value[ "cpro_w" ];
		}
		
		public function set cpro_w( value : Number ) : void {
			_value[ "cpro_w" ] = value;
		}
		
		public function get cpro_template() : String {
			return _value[ "cpro_template" ];
		}
		
		public function set cpro_template( value : String ) : void {
			_value[ "cpro_template" ] = value;
		}
		
		public function get cpro_filters() : String {
			return _value[ "cpro_filters" ];
		}
		
		public function set cpro_filters( value : String ) : void {
			_value[ "cpro_filters" ] = value;
		}
		
		public function get cpro_keywords() : Array {
			return _value[ "cpro_keywords" ];
		}
		
		public function set cpro_keywords( value : Array ) : void {
			_value[ "cpro_keywords" ] = value;
		}
		
		public function get cpro_url() : String {
			return _value[ "cpro_url" ];
		}
		
		public function set cpro_url( value : String ) : void {
			_value[ "cpro_url" ] = value;
		}
		
		public function get cpro_channel() : String {
			return _value[ "cpro_channel" ];
		}
		
		public function set cpro_channel( value : String ) : void {
			_value[ "cpro_channel" ] = value;
		}
		
		public function get cpro_client() : String {
			return _value[ "cpro_client" ];
		}
		
		public function set cpro_client( value : String ) : void {
			_value[ "cpro_client" ] = value;
		}
	
	}
}
