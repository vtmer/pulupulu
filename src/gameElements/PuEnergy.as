package gameElements
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * 屁能（遮罩）
	 *
	 * @author SHENGbanX
	 */
	public class PuEnergy extends Sprite
	{
		private var puEnergyArt:Image;
		
		public function PuEnergy()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			createPuEnergyArt();
		}
		
		private function createPuEnergyArt():void
		{
			puEnergyArt = new Image(Assets.getAtlas().getTexture("puEnergy"));
			this.addChild(puEnergyArt);
		}
	
	}

}