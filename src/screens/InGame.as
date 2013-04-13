package screens
{
	import events.NavigationEvent;
	import flash.geom.Rectangle;
	import gameElements.PuEnergy;
	import gameElements.Puman;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class InGame extends Sprite
	{
		private var puman:Puman;
		private var pauseButton:Button;
		private var gameBar:Image;
		private var bg:Image;
		private var continueButton:Button;
		private var restartButton:Button;
		private var exitButton:Button;
		private var blackBg:Quad;
		private var gameArea:Rectangle;
		private var gameState:String;
		private var puEnergy:PuEnergy;
		
		public function InGame()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			gameBar = new Image(Assets.getAtlas().getTexture("gameBar"));
			this.addChild(gameBar);
			
			puman = new Puman();
			puman.x = 350;
			puman.y = 1150;
			this.addChild(puman);
			trace("Puman");
			
			puEnergy = new PuEnergy();
			puEnergy.x = 591;
			puEnergy.y = 85;
			this.addChild(puEnergy);
			
			pauseButton = new Button(Assets.getAtlas().getTexture("pauseBtn"));
			pauseButton.x = 561;
			pauseButton.y = 12;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			//暂停页面
			pauseView();
			
			//游戏区域
			gameArea = new Rectangle(0, 100, stage.stageWidth, stage.stageHeight - 250);
		}
		
		private function pauseView():void
		{
			blackBg = new Quad(720, 1280, 0x000000, true);
			blackBg.alpha = .4;
			this.addChild(blackBg);
			
			continueButton = new Button(Assets.getAtlas().getTexture("continueBtn2"));
			continueButton.x = 125;
			continueButton.y = 533;
			this.addChild(continueButton);
			
			restartButton = new Button(Assets.getAtlas().getTexture("restartBtn"));
			restartButton.x = 125;
			restartButton.y = 275;
			this.addChild(restartButton);
			
			exitButton = new Button(Assets.getAtlas().getTexture("exitBtn"));
			exitButton.x = 125;
			exitButton.y = 798;
			this.addChild(exitButton);
			
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
		}
		
		private function onPauseButtonClick(e:Event):void
		{
			blackBg.visible = true;
			continueButton.visible = true;
			restartButton.visible = true;
			exitButton.visible = true;
			continueButton.addEventListener(Event.TRIGGERED, onContinueButton);
			exitButton.addEventListener(Event.TRIGGERED, onExitBtn);
		}
		
		private function onExitBtn(e:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "mainMenu"}, true));
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
			trace("MainMenu");
		}
		
		private function onContinueButton(e:Event):void
		{
			trace("continue");
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
			
			continueButton.removeEventListener(Event.TRIGGERED, onContinueButton);
			
			launchPuman();
		}
		
		private function launchPuman():void
		{
			this.addEventListener(Event.ENTER_FRAME, onGameState);
		}
		
		private function onGameState(e:Event):void
		{
			
			//游戏状态
			switch (gameState)
			{
				//重力、阻力、加速度？
				case "idle": 
					if (puman.y > stage.stageHeight)
					{
						//初始化puman
						
					}
					else
					{
						gameState = "flying";
					}
					break;
				case "flying": 
					break;
				case "over": 
					break;
			}
		
		}
		
		public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			
			//puman.x = -stage.stageWidth * 0.5;
			//puman.y = -stage.stageHeight;
			
			//闲置
			gameState = "idle";
		
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	
	}

}