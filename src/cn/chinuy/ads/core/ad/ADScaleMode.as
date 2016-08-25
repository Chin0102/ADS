package cn.chinuy.ads.core.ad {
	
	/**
	 * @author chin
	 */
	public class ADScaleMode {
		
		//从不调整图片的尺寸
		public static const OriginalSize : String = "originalSize";
		//拉伸平铺
		public static const Tile : String = "tile";
//		//保持宽高比例,充满范围 (范围内不会有空白)
//		public static const CeilSizeAlwaysScale : String = "ceilSize_alwaysScale";
		//保持宽高比例,尽量不调整尺寸在范围内自适应 (当宽或高都不超过范围时,等同于OriginalSize; 否则等同于AlwaysScale)
		public static const FloorSizeAlwaysScale : String = "floorSize_alwaysScale";
		//保持宽高比例,完整显示在范围内
		public static const AlwaysScale : String = "alwaysScale";
	
	}
}
