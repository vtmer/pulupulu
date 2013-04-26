package gameElements
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Pu extends Sprite
	{
		private var puArt:Image;
		
		public function Pu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			createPu();
		}
		
		private function createPu():void
		{
			puArt = new Image(Assets.getAtlas().getTexture("pu"));
			puArt.x = Math.ceil(-puArt.width / 4);
			puArt.y = Math.ceil(-puArt.height / 2);
			puArt.scaleX = 0.5;
			puArt.scaleY = 0.5;
			this.addChild(puArt);
			puArt.addEventListener(Event.ENTER_FRAME, puAnimation);
		}
		
		private function puAnimation(e:Event):void
		{
			var myTimer:Timer = new Timer(300, 5);
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			myTimer.start();
			if (puArt.alpha < 0.1)
				this.removeChild(puArt);
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			puArt.scaleX += 0.1;
			puArt.scaleY += 0.1;
			puArt.alpha -= 0.2;
			//位置修正
			puArt.x -= (puArt.width * 0.25) / 5;
			puArt.y += 10;
		
		}
	
	}

}