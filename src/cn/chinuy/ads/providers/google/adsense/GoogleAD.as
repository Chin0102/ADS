package cn.chinuy.ads.providers.google.adsense {
	import cn.chinuy.ads.core.ad.AD;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	
	/**
	 * @author Chin
	 */
	public class GoogleAD extends AD {
		
		private static var ADW : Number = 380;
		private static var ADH : Number = 317;
		
		private var ad : Sprite;
		private var loader : Loader;
		
		private var _param : GoogleADParam;
		
		private var timer : Timer = new Timer( 50, 1 );
		
		public function GoogleAD( param : GoogleADParam ) {
			super();
			width = ADW;
			height = ADH;
			hcenter = vcenter = 0;
			
			_param = param;
			timer.addEventListener( TimerEvent.TIMER, onTimer );
			layout.addEventListener( Event.RESIZE, onParentResize );
		}
		
		override public function destroy() : void {
			if( ad ) {
				ad[ "destroy" ]();
			} else {
				GoogleADSense.instance.removeTaskAD( this );
			}
		}
		
		private function onParentResize( e : Event ) : void {
			renderEnable = false;
			timer.stop();
			timer.start();
		}
		
		private function onTimer( event : TimerEvent ) : void {
			renderEnable = true;
		}
		
		override protected function sizeRender() : void {
			super.sizeRender();
			if( ad ) {
				ad[ "setSize" ]( width, height );
				ad[ "setX" ]( x );
				ad[ "setY" ]( y );
			}
		}
		
		override public function display() : void {
			if( param.adType == "overlay" ) {
				position.top = 0;
				left = right = top = bottom = 0;
			}
			GoogleADSense.instance.loadAD( this );
		}
		
		public function get param() : GoogleADParam {
			return _param;
		}
		
		public function onAdsRequestResult( callbackObj : Object ) : void {
			if( callbackObj[ "success" ]) {
				ad = callbackObj[ "ads" ][ 0 ][ "getAdPlayerMovieClip" ]();
				ad[ "onAdEvent" ] = onAdEvent;
				ad[ "load" ]();
				ad[ "playAds" ]();
				setADReady();
			} else {
				setADFinish( true, callbackObj[ "errorMsg" ]);
			}
		}
		
		private function onAdEvent( e : String ) : void {
		}
	
	}
}

