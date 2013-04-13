package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class NavigationEvent extends Event 
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		//参数
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object,bubbles:Boolean = false) 
		{
			super(type, bubbles);
			params = _params;
			
		}
		
	}

}