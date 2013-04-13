package screens
{
	import events.NavigationEvent;
	import starling.display.Button;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.BlendMode;
	import starling.utils.deg2rad;
	
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
		private var pu:Image;
		private var _currenDate:Date;
		private var screenMode:String;
		private var continueBtn:Button;
		private var aboutBtn:Button;
		
		public function Welcome()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawScreen();
		}
		
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			title.x = 96;
			title.y = 183;
			this.addChild(title);
			
			pu = new Image(Assets.getAtlas().getTexture("pu"));
			pu.x = 370;
			pu.y = 1260;
			pu.rotation = deg2rad(250);
			this.addChild(pu);
			
			puman = new Image(Assets.getAtlas().getTexture("puman1"));
			puman.x = 220;
			puman.y = 1050;
			this.addChild(puman);
			
			startBtn = new Button(Assets.getAtlas().getTexture("startBtn"));
			startBtn.x = 176;
			startBtn.y = 421;
			startBtn.addEventListener(Event.TRIGGERED, onStartBtnClick);
			this.addChild(startBtn);
			
			continueBtn = new Button(Assets.getAtlas().getTexture("continueBtn"));
			continueBtn.x = 176;
			continueBtn.y = 567;
			continueBtn.addEventListener(Event.TRIGGERED, onContinueBtnClick)
			this.addChild(continueBtn);
			
			rankBtn = new Button(Assets.getAtlas().getTexture("rankBtn"));
			rankBtn.x = 176;
			rankBtn.y = 729;
			rankBtn.addEventListener(Event.TRIGGERED, onRankBtnClick)
			this.addChild(rankBtn);
			
			aboutBtn = new Button(Assets.getAtlas().getTexture("aboutBtn"));
			aboutBtn.x = 176;
			aboutBtn.y = 885;
			aboutBtn.addEventListener(Event.TRIGGERED, onAboutBtnClick)
			this.addChild(aboutBtn);
		
		}
		
		private function onContinueBtnClick(e:Event):void 
		{
			
		}
		
		private function onAboutBtnClick(e:Event):void 
		{
			
		}
		
		private function onRankBtnClick(e:Event):void
		{
		
		}
		
		private function onStartBtnClick(e:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
		}
		
		/**
		 *初始化welcome screen
		 */
		public function initialize():void
		{
			//disposeTemporarily();
			
			//this.visible = true();
			
			//如果是从其他页面回来，不用从新播放背景音乐(暂时没写）
			
			screenMode = "welcome";
			puman.visible = true;
			pu.visible = true;
			startBtn.visible = true;
			rankBtn.visible = true;
			
			this.addEventListener(Event.ENTER_FRAME, puAnimation);
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME, puAnimation);
			//处理音乐（暂时没写）
		}
		
	   
		
		public function showAbout():void 
		{
			
		}
		
		public function showWelcomeScreen():void 
		{
			this.visible = true;
		}
		
		private function puAnimation(e:Event):void
		{
			_currenDate = new Date();
			pu.x = 370 + (Math.cos(_currenDate.getTime() * 0.002)) * 10;
			puman.x = 220 + (Math.sin(_currenDate.getTime() * 0.002)) * 5;
			//pu.y = 1200 + (Math.sin(_currenDate.getTime() * 0.002)) * 10;
		}
	
	}

}