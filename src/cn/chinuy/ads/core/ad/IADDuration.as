package cn.chinuy.ads.core.ad {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface IADDuration extends IEventDispatcher {
		function get secondStart() : int;
		function get secondEnd() : int;
		function get secondCurrent() : int;
		function get timeLeft() : int;
		function start( ad : IAD ) : void;
	}
}
