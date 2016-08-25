package cn.chinuy.ads.utils {
	import cn.chinuy.data.string.isNull;
	
	/**
	 * @author chin
	 */
	public class ParamUtil {
		
		public static function getObject( str : String ) : Object {
			var obj : Object = {};
			if( !isNull( str )) {
				var arr : Array = str.split( "," );
				var len : int = arr.length;
				for( var i : int = 0; i < len; i++ ) {
					var temp : String = arr[ i ];
					var tempArr : Array = temp.split( ":" );
					var key : String = tempArr[ 0 ];
					var value : String = decodeURIComponent( tempArr[ 1 ]);
					obj[ key ] = value;
				}
			}
			return obj;
		}
		
		public static function getValue( obj : Object, key : String, def : * = null ) : * {
			var value : * = obj[ key ];
			if( value == null ) {
				value = def;
			}
			return value;
		}
		
		public static function getArray( obj : Object, key : String ) : Array {
			var value : String = obj[ key ];
			if( value != null ) {
				return value.split( "," );
			}
			return null;
		}
	
	}
}
