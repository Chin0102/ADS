package cn.chinuy.ads.core.ad {
	import cn.chinuy.net.loader.SWFProxy;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
	 * @author Chin
	 */
	public class SWFContainerAD extends AD {
		
		protected var swf : SWFProxy;
		
		public function SWFContainerAD() {
			super();
			initSDK();
		}
		
		protected function initSDK() : void {
			swf = new SWFProxy();
		}
		
		protected function load( url : String ) : void {
			if( !swf.valid && !swf.loading ) {
				if( url.indexOf( "http" ) == 0 ) {
					swf.url = url;
					swf.addEventListener( Event.INIT, onSdkLoadSuccess );
					swf.addEventListener( IOErrorEvent.IO_ERROR, onSdkLoadError );
					swf.load();
				} else {
					setADFinish( true, this + ".sdk invalid url" );
				}
			}
		}
		
		override public function destroy() : void {
			removeLoadEvent();
			if( content == swf.loader.parent ) {
				content.removeChild( swf.loader );
			}
			swf.unload();
		}
		
		protected function removeLoadEvent() : void {
			swf.removeEventListener( Event.COMPLETE, onSdkLoadSuccess );
			swf.removeEventListener( IOErrorEvent.IO_ERROR, onSdkLoadError );
		}
		
		protected function onSdkLoadError( e : Event ) : void {
			removeLoadEvent();
			setADFinish( true, this + ".sdk load error" );
		}
		
		protected function onSdkLoadSuccess( e : Event ) : void {
			removeLoadEvent();
		}
	
	}
}
