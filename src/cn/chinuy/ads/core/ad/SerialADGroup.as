package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.ADEvent;
	
	/**
	 * @author chin
	 */
	public class SerialADGroup extends ADGroup {
		
		public function SerialADGroup( group : Array ) {
			super( group );
		}
		
		private function switchAD() : void {
			if( ad ) {
				setADEvent( ad.removeEventListener );
				if( this == ad.displayObject.parent )
					removeChild( ad.displayObject );
				ad.destroy();
			}
			if( group.length > 0 ) {
				ad = group.shift();
				ad.init( position );
				addChild( ad.displayObject );
				setADEvent( ad.addEventListener );
			} else {
				dispatchEvent( new ADEvent( ADEvent.Finished ));
			}
		}
		
		protected function setADEvent( func : Function ) : void {
			func( ADEvent.Ready, onADReady );
			func( ADEvent.Error, onADError );
			func( ADEvent.Progress, onADProgress );
			func( ADEvent.Finished, onADFinished );
		}
		
		override protected function onInit() : void {
			switchAD();
		}
		
		protected function onADReady( e : ADEvent ) : void {
			if( !adReady ) {
				adReady = true;
				dispatchEvent( e );
			}
			ad.display();
		}
		
		protected function onADFinished( e : ADEvent ) : void {
			switchAD();
		}
		
		protected function onADError( e : ADEvent ) : void {
			dispatchEvent( e );
		}
		
		private function onADProgress( e : ADEvent ) : void {
			dispatchEvent( e );
		}
	}
}
