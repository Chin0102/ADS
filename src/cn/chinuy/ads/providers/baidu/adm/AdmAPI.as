package cn.chinuy.ads.providers.baidu.adm {
	import cn.chinuy.data.string.as2_escape;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * @author chin
	 */
	public class AdmAPI extends EventDispatcher {
		
		private var _xmlURL : String;
		private var _status : int; /** 0=无状态||1=加载中||2=加载成功||3=加载失败 */
		private var _hasInfo : Boolean;
		private var _info : Object;
		private var loader : URLLoader;
		
		public function AdmAPI( param : AdmParam ) {
			_xmlURL = "http://cb.baidu.com/ecom?di=" + param.positionID + "&tm=BAIDU_CLB_XML&screen_h=&screen_w=&asp_refer=" + as2_escape( param.referer ) + "&asp_url=" + as2_escape( param.userDomain ) + "&b_lang=zh-CN&return_type=1";
			_status = 0;
		}
		
		public function unload() : void {
			if( loader ) {
				try {
					loader.close();
				} catch( e : Error ) {
				}
			}
		}
		
		public function load() : void {
			_status = 1;
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onLoad );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadError );
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onLoadError );
			loader.load( new URLRequest( _xmlURL ));
		}
		
		public function get info() : Object {
			return _info;
		}
		
		public function hasInfo() : Boolean {
			return _hasInfo;
		}
		
		private function onLoadError( e : Event ) : void {
			_status = 3;
			dispatchEvent( e );
		}
		
		private function onLoad( e : Event ) : void {
			_status = 2;
			_info = {};
			XML.ignoreWhitespace = true;
			var xml : XML = XML(( e.target as URLLoader ).data );
			var xc : XMLList = xml.children();
			_hasInfo = xc[ 0 ] == "1";
			if( _hasInfo ) {
				var ad : XML = xc[ 1 ];
				var childs : XMLList = ad.children();
				var length : int = childs.length();
				for( var i : int; i < length; i++ ) {
					var node : XML = childs[ i ];
					_info[ node.localName()] = String( node[ 0 ]);
				}
			}
			dispatchEvent( e );
		}
	}
}
