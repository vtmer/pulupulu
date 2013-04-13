package gameElements
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class Puman extends Sprite
	{
		private var pumanArt:Image;
		private var pumanA:Number;
		
		public function Puman()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			createPumanArt();
		}
		
		private function createPumanArt():void
		{
			pumanArt = new Image(Assets.getAtlas().getTexture("puman2"));
			pumanArt.x = Math.ceil(-pumanArt.width / 2);
			pumanArt.y = Math.ceil(-pumanArt.height / 2);
			this.addChild(pumanArt);
			pumanArt.addEventListener(Event.ADDED_TO_STAGE, onAddTo)
			trace("2222");
		}
		
		private function onAddTo(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddTo);
			pumanA = 1000;
		}
	
	}

}