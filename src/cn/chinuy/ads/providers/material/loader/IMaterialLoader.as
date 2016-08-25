package cn.chinuy.ads.providers.material.loader {
	import cn.chinuy.display.layout.ILayoutElement;
	
	/**
	 * @author chin
	 */
	public interface IMaterialLoader extends ILayoutElement {
		
		function get ready() : Boolean;
		
		function get url() : String;
		function set url( value : String ) : void;
		
		function get originalWidth() : Number;
		function get originalHeight() : Number;
		
		function play() : void;
		function stop() : void;
	}
}
