package cn.chinuy.ads.providers.google.adsense {
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	
	/**
	 * @author Chin
	 */
	public class GoogleADSense extends Sprite {
		
		private static var _instance : GoogleADSense;
		
		public static function get instance() : GoogleADSense {
			if( _instance == null ) {
				_instance = new GoogleADSense();
			}
			return _instance;
		}
		
		private var loader : Loader;
		private var adsense : Sprite;
		private var loading : Boolean;
		private var error : Boolean;
		private var doing : GoogleAD;
		private var task : Array;
		
		public function GoogleADSense() {
			task = [];
		}
		
		public function loadAD( adLoader : GoogleAD ) : void {
			if( loader == null ) {
				loading = true;
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadSuccess );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onLoadError );
				loader.load( new URLRequest( "http://pagead2.googlesyndication.com/pagead/scache/googlevideoadslibraryas3.swf" ));
				addChild( loader );
			}
			task.push( adLoader );
			doTask();
		}
		
		public function removeTaskAD( adLoader : GoogleAD ) : void {
			var i : int = task.indexOf( adLoader );
			if( i >= 0 ) {
				task.splice( i, 1 );
			}
		}
		
		private function removeListeners() : void {
			loader.contentLoaderInfo.removeEventListener( Event.INIT, onLoadSuccess );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onLoadError );
		}
		
		private function onLoadSuccess( e : Event ) : void {
			removeListeners();
			loading = error = false;
			adsense = loader.content as Sprite;
			doTask();
		}
		
		private function onLoadError( e : Event ) : void {
			removeListeners();
			error = true;
			loading = false;
			doTask();
		}
		
		private function doTask() : void {
			if( !loading ) {
				if( task.length > 0 ) {
					doing = task.shift();
					loading = true;
					if( error ) {
						onAdsRequestResult({ success:false, errorMsg:"load library error" });
					} else {
						adsense[ "requestAds" ]( doing.param.value, onAdsRequestResult );
					}
				}
			}
		}
		
		private function onAdsRequestResult( callbackObj : Object ) : void {
			loading = false;
			if( doing ) {
				if( doing.parent == null ) {
					var ad : Sprite = callbackObj[ "ads" ][ 0 ][ "getAdPlayerMovieClip" ]();
					ad[ "destroy" ]();
				} else {
					doing.onAdsRequestResult( callbackObj );
				}
			}
			doTask();
		}
	}
}

