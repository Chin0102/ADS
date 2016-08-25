package cn.chinuy.ads.core.ad {
	import cn.chinuy.ads.core.position.IPosition;
	import cn.chinuy.display.layout.ILayoutElement;
	
	/**
	 * @author chin
	 */
	public interface IAD extends ILayoutElement {
		function get position() : IPosition;
		function get ready() : Boolean;
		function get hasTimeline() : Boolean;
		function get duration() : IADDuration;
		function set duration( value : IADDuration ) : void;
		function setDuration( timeEnd : int, timeStart : int = 0, duration : int = 0, useADTimeline : Boolean = false ) : void;
		//加载
		function init( position : IPosition ) : void;
		//显示
		function display() : void;
		//销毁
		function destroy() : void;
		
		function click() : void;
	}
}
