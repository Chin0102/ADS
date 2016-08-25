package cn.chinuy.ads.core {
	
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class ADEvent extends Event {
		
		public static const ProviderCreateSuccess : String = "Provider.CreateSuccess";
		public static const ProviderCreateFailed : String = "Provider.CreateFailed";
		public static const ProviderDestroy : String = "Provider.Destroy";
		
		public static const CreateSuccess : String = "AD.CreateSuccess";
		public static const CreateFailed : String = "AD.CreateFailed";
		
		public static const Error : String = "AD.Error";
		public static const Ready : String = "AD.Ready";
		public static const Click : String = "AD.Click";
		public static const Progress : String = "AD.Progress";
		public static const Finished : String = "AD.Finished";
		
		public static const MaterialProgress : String = "AD.Material.Progress";
		
//暂未从Finished中区分开
//		public static const Close : String = "AD.Close";
//		public static const TimeOut : String = "AD.TimeOut";
		
		public var msg : String;
		public var value : *;
		
		public function ADEvent( type : String ) {
			super( type );
		}
		
		override public function clone() : Event {
			var e : ADEvent = new ADEvent( type );
			e.msg = msg;
			e.value = value;
			return e;
		}
		
		override public function toString() : String {
			var str : String = "[event:type=" + type;
			if( msg ) {
				str += ",msg=" + msg;
			}
			str += "]";
			return str;
		}
	}
}
