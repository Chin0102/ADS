package cn.chinuy.ads.providers.material {
	import cn.chinuy.ads.core.ADEvent;
	import cn.chinuy.ads.core.ad.AD;
	import cn.chinuy.ads.core.ad.ADScaleMode;
	import cn.chinuy.ads.core.position.IPosition;
	import cn.chinuy.ads.providers.material.loader.IMaterialLoader;
	import cn.chinuy.ads.providers.material.loader.ImageLoader;
	import cn.chinuy.ads.providers.material.loader.VideoLoader;
	import cn.chinuy.data.string.extension;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
	 * @author chin
	 */
	public class MaterialAD extends AD {
		
		public static const NAME : String = "material";
		public static const VIDEO : String = "video";
		public static const IMAGE : String = "image";
		
		public static function create( param : MaterialADParam ) : MaterialAD {
			if( param.type == null || param.type == "" ) {
				var type : String = extension( param.url );
				switch( type ) {
					case "flv":
					case "mp4":
						param.type = VIDEO;
						break;
					case "gif":
					case "jpg":
					case "jpeg":
					case "png":
					case "swf":
					default:
						param.type = IMAGE;
						break;
				}
			}
			var loader : IMaterialLoader;
			switch( param.type ) {
				case VIDEO:
					loader = new VideoLoader();
					break;
				default:
					loader = new ImageLoader();
					break;
			}
			return new MaterialAD( param, loader );
		}
		
		private var _param : MaterialADParam;
		protected var loader : IMaterialLoader;
		
		public function MaterialAD( param : MaterialADParam, loader : IMaterialLoader ) {
			super();
			tile( this );
			tile( loader );
			this.loader = loader;
			_param = param;
			cover.link = link;
			cover.visible = link != "";
		}
		
		public function set displayWidth( value : Number ) : void {
			param.w = value;
		}
		
		public function get displayWidth() : Number {
			return param.w;
		}
		
		public function set displayHeight( value : Number ) : void {
			param.h = value;
		}
		
		public function get displayHeight() : Number {
			return param.h;
		}
		
		public function get param() : MaterialADParam {
			return _param;
		}
		
		public function get url() : String {
			return param.url;
		}
		
		public function get link() : String {
			return param.link;
		}
		
		override public function destroy() : void {
			super.destroy();
			if( loader.url != null ) {
				removeLoaderEvent();
				loader.removeEventListener( ADEvent.Progress, dispatchEvent );
				if( content == loader.displayObject.parent ) {
					content.removeChild( loader.displayObject );
				}
				loader.url = null;
			}
		}
		
		override public function init( position : IPosition ) : void {
			super.init( position );
			if( url && url.indexOf( "http" ) == 0 ) {
				loader.addEventListener( Event.COMPLETE, onLoadComplete );
				loader.addEventListener( IOErrorEvent.IO_ERROR, onLoadError );
				loader.addEventListener( ADEvent.MaterialProgress, dispatchEvent );
				loader.url = url;
			} else {
				setADFinish( true, "invalid material url" );
			}
		}
		
		override public function get hasTimeline() : Boolean {
			return loader is VideoLoader;
		}
		
		override public function display() : void {
			super.display();
			loader.play();
		}
		
		override public function set scaleMode( value : String ) : void {
			super.scaleMode = value;
			updateLoader();
		}
		
		override protected function sizeRender() : void {
			updateLoader();
		}
		
		private function removeLoaderEvent() : void {
			loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onLoadError );
		}
		
		private function onLoadError( event : IOErrorEvent ) : void {
			removeLoaderEvent();
			setADFinish( true, loader + "material load error" );
		}
		
		private function onLoadComplete( event : Event ) : void {
			removeLoaderEvent();
			if( isNaN( displayWidth )) {
				displayWidth = loader.originalWidth;
			}
			if( isNaN( displayHeight )) {
				displayHeight = loader.originalHeight;
			}
			if( displayWidth == -1 || displayHeight == -1 )
				scaleMode = ADScaleMode.Tile;
			content.addChild( loader.displayObject );
			setADReady();
		}
		
		private function updateLoader() : void {
			if( !loader.ready )
				return;
			var sm : String = scaleMode;
			if( sm == ADScaleMode.FloorSizeAlwaysScale ) {
				sm = width > displayWidth && height > displayHeight ? ADScaleMode.OriginalSize : ADScaleMode.AlwaysScale;
			}
			switch( sm ) {
				case ADScaleMode.Tile:
					tile( content );
					tile( cover );
					break;
				case ADScaleMode.OriginalSize:
					midAlign( content, displayWidth, displayHeight );
					midAlign( cover, displayWidth, displayHeight );
					break;
				case ADScaleMode.AlwaysScale:
					var os : Number = displayWidth / displayHeight;
					if( os > width / height ) {
						var h : Number = width / os;
						midAlign( content, width, h );
						midAlign( cover, width, h );
					} else {
						var w : Number = height * os;
						midAlign( content, w, height );
						midAlign( cover, w, height );
					}
					break;
			}
		}
	
	}
}
