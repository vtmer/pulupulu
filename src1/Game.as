package  
{
	import starling.events.Event;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			trace("starling framework initialized");
		}
		
	}

}