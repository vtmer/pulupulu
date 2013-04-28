package gameElements
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameProps extends Sprite
	{
		private var num:int = 4;
		public var propsName:String;
		private var sweetPatato1:Image;
		private var ranN:int = 0;
		private var sweetPatato2:Image;
		private var radish:Image;
		private var chilli:Image;
		
		public function GameProps()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			createProps();
		
		}
		
		private function createProps():void
		{
			ranN = Math.random() * num;
			trace(ranN);
			if (ranN == 0)
			{
				sweetPatato1 = new Image(Assets.getAtlas().getTexture("sweetPatato1"));
				this.addChild(sweetPatato1);
				propsName = "sweetPatato1";
			}
			else if (ranN == 1)
			{
				sweetPatato2 = new Image(Assets.getAtlas().getTexture("sweetPatato2"));
				this.addChild(sweetPatato2);
				propsName = "sweetPatato2";
			}
			else if (ranN == 2)
			{
				chilli = new Image(Assets.getAtlas().getTexture("chilli"));
				this.addChild(chilli);
				propsName = "chilli";
			}
			else
			{
				radish = new Image(Assets.getAtlas().getTexture("radish"))
				;
				this.addChild(radish);
				propsName = "radish";
			}
		}
	
	}

}