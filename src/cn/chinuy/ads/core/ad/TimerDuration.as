package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.ADEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * @author chin
	 */
	public class TimerDuration extends EventDispatcher implements IADDuration {
		
		protected var timeStart : int;
		protected var timeEnd : int;
		protected var timeCurrent : int;
		protected var duration : int;
		protected var ad : IAD;
		private var timer : Timer;
		
		public function TimerDuration( timeEnd : int, timeStart : int = 0, duration : int = 0 ) {
			super();
			this.timeEnd = timeEnd;
			this.timeStart = timeCurrent = timeStart;
			this.duration = duration <= 0 ? timeEnd : duration;
		}
		
		public function get secondStart() : int {
			return timeStart;
		}
		
		public function get secondEnd() : int {
			return timeEnd;
		}
		
		public function get secondCurrent() : int {
			return timeCurrent;
		}
		
		public function get timeLeft() : int {
			return duration - timeCurrent;
		}
		
		public function start( ad : IAD ) : void {
			this.ad = ad;
			sendProgressEvent();
			timerStart();
		}
		
		protected function sendProgressEvent() : void {
			ad.dispatchEvent( new ADEvent( ADEvent.Progress ));
			if( timeCurrent >= timeEnd ) {
				onFinished();
				ad.dispatchEvent( new ADEvent( ADEvent.Finished ));
			}
		}
		
		protected function onFinished() : void {
			timerStop();
		}
		
		protected function onTimer( e : TimerEvent ) : void {
			timeCurrent++;
			sendProgressEvent();
		}
		
		final protected function timerStart() : void {
			if( timer == null ) {
				timer = new Timer( 1000 );
			}
			if( !timer.running ) {
				timer.addEventListener( TimerEvent.TIMER, onTimer );
				timer.start();
			}
		}
		
		final protected function timerStop() : void {
			if( timer != null && timer.running ) {
				timer.removeEventListener( TimerEvent.TIMER, onTimer );
				timer.stop();
			}
		}
	
	}
}
