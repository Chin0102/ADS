package cn.chinuy.ads.providers.google.adsense {
	
	/**
	 * @author chin
	 */
	public class GoogleADParam {
		
		public var publisherId : String;
		public var channels : Array;
		public var adType : String;
		public var contentId : String;
		public var descriptionUrl : String;
		public var pubWidth : Number;
		public var pubHeight : Number;
		
		public function GoogleADParam( publisherId : String, channels : Array, adType : String, contentId : String, descriptionUrl : String, pubWidth : Number, pubHeight : Number ) {
			this.publisherId = publisherId;
			this.channels = channels;
			this.adType = adType;
			this.contentId = contentId;
			this.descriptionUrl = descriptionUrl;
			this.pubWidth = pubWidth;
			this.pubHeight = pubHeight;
		}
		
		public function get value() : Object {
			return { publisherId:publisherId, channels:channels, adType:adType, contentId:contentId, descriptionUrl:descriptionUrl, pubWidth:pubWidth, pubHeight:pubHeight };
		}
	}
}
