package cn.chinuy.ads.providers.material.loader {
	
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * @author chin
	 */
	public class ImageLoader extends UIContainer implements IMaterialLoader {
		
		private var _url : String;
		
		protected var loadLoader : Loader;
		protected var showLoader : Loader;
		
		public function ImageLoader( url : String = null ) {
			super();
			this.url = url;
		}
		
		public function get url() : String {
			return _url;
		}
		
		public function set url( value : String ) : void {
			var changed : Boolean = url != value;
			if( changed ) {
				_url = value;
				removeLoadLoader( true );
				removeShowLoader();
				if( url != null ) {
					loadLoader = new Loader();
					loadLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
					loadLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
					loadLoader.load( new URLRequest( value ));
				}
			}
		}
		
		public function play() : void {
		}
		
		public function stop() : void {
		}
		
		public function get ready() : Boolean {
			return showLoader != null;
		}
		
		public function get originalWidth() : Number {
			if( ready ) {
				return showLoader.contentLoaderInfo.width;
			}
			return -1;
		}
		
		public function get originalHeight() : Number {
			if( ready ) {
				return showLoader.contentLoaderInfo.height;
			}
			return -1;
		}
		
		private function set loader( value : Loader ) : void {
			if( value ) {
				removeLoadLoader( value != loadLoader );
				removeShowLoader();
				showLoader = value;
				updateShowLoader();
				addChild( showLoader );
			}
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			updateShowLoader();
		}
		
		protected function updateShowLoader() : void {
			if( ready ) {
				showLoader.scaleX = width / originalWidth;
				showLoader.scaleY = height / originalHeight;
			}
		}
		
		protected function removeShowLoader() : void {
			if( showLoader ) {
				showLoader.unloadAndStop( true );
				removeChild( showLoader );
				showLoader = null;
			}
		}
		
		protected function removeLoadLoader( unload : Boolean = true ) : void {
			if( loadLoader ) {
				loadLoader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
				loadLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
				if( unload ) {
					try {
						loadLoader.unloadAndStop( true );
					} catch( e : Error ) {
						loadLoader.unload();
					}
				}
				loadLoader = null;
			}
		}
		
		private function onLoadComplete( e : Event ) : void {
			this.loader = loadLoader;
			dispatchEvent( e );
		}
		
		private function onIOError( e : Event ) : void {
			dispatchEvent( e );
		}
	}
}
