package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.ADEvent;
	
	/**
	 * @author chin
	 */
	public class ADDuration extends TimerDuration {
		
		public function ADDuration( timeEnd : int, timeStart : int = 0, duration : int = 0 ) {
			super( timeEnd, timeStart, duration );
		}
		
		override public function start( ad : IAD ) : void {
			this.ad = ad;
			sendProgressEvent();
			ad.addEventListener( ADEvent.MaterialProgress, onMaterialProgress );
		}
		
		override protected function onFinished() : void {
			super.onFinished();
			ad.removeEventListener( ADEvent.MaterialProgress, onMaterialProgress );
		}
		
		private function onMaterialProgress( e : ADEvent ) : void {
			var current : int = Math.floor( e.value[ "timeCurrent" ]);
			var total : int = Math.floor( e.value[ "timeTotal" ]);
			if( current < total ) {
				var time : int = timeStart + current;
				if( timeCurrent != time ) {
					timeCurrent = time;
					sendProgressEvent();
				}
			} else {
				timerStart();
			}
		}
	}
}
