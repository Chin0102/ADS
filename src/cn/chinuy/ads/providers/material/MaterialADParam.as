package cn.chinuy.ads.providers.material {
	import cn.chinuy.ads.utils.ParamUtil;
	
	/**
	 * @author chin
	 */
	public class MaterialADParam {
		public var url : String;
		public var link : String;
		public var w : Number;
		public var h : Number;
		public var type : String;
		
		public function MaterialADParam( url : String, link : String = "", w : Number = NaN, h : Number = NaN, type : String = "" ) {
			this.url = url;
			this.link = link;
			this.w = w;
			this.h = h;
			this.type = type;
		}
		
		public static function parse( param : * ) : MaterialADParam {
			if( param is MaterialADParam ) {
				return param;
			}
			var obj : Object = typeof( param ) == "string" ? ParamUtil.getObject( param ) : param;
			var url : String = ParamUtil.getValue( obj, "url" );
			var link : String = ParamUtil.getValue( obj, "link", "" );
			var w : Number = ParamUtil.getValue( obj, "w", NaN );
			var h : Number = ParamUtil.getValue( obj, "h", NaN );
			var type : String = ParamUtil.getValue( obj, "type", "" );
			
			if( url && url.indexOf( "http" ) == 0 ) {
				return new MaterialADParam( url, link, w, h, type );
			}
			return null;
		}
	}
}
