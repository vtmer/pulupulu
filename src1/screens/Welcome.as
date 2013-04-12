package screens 
{
	import starling.display.Button;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.BlendMode;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class Welcome extends Sprite 
	{
		private var bg:Image;
		private var title:Image;
		private var puman:Image;
		private var startBtn:Button;
		private var rankBtn:Button;
		
		public function Welcome() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.blendMode = BlendMode.NONE;
			this.addChild(bg);
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			title.x = 70;
			title.y = 155;
			this.addChild(title);
			
			puman = new Image(Assets.getAtlas().getTexture("puman"));
			puman.x = 177;
			puman.y = 915;
			this.addChild(puman);
			
			startBtn = new Button(Assets.getAtlas().getTexture("startBtn"),"",Assets.getAtlas().getTexture("startBtn2"));
			startBtn.x = 156;
			startBtn.y = 455;
			this.addChild(startBtn);
			
			rankBtn = new Button(Assets.getAtlas().getTexture("rankBtn"),"",Assets.getAtlas().getTexture("rankBtn2"));
			rankBtn.x = 205;
			rankBtn.y = 640;
			this.addChild(rankBtn);
		}
		
		
		
	}

}