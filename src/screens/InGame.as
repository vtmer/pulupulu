package screens
{
	import events.NavigationEvent;
	import flash.events.AccelerometerEvent;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import gameElements.PuEnergy;
	import gameElements.Puman;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
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
		private var accX:Number;
		private var xSpeed:Number = 0;
		private var vAcceleration:Number = 0.5;
		private var vVelocity:Number;
		private var liveScore:Number;
		private var myAcc = new Accelerometer();
		private const middleScreen = 640;
		private var tips:TextField;
		private var pausevV:Number;
		
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
			
			tips = new TextField(500, 500, "Touch to play!", "Verdana", 50);
			tips.x = 100;
			tips.y = 400;
			this.addChild(tips);
			tips.addEventListener(TouchEvent.TOUCH, onTouchTips);
			
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
		
		private function onTouchTips(e:TouchEvent):void
		{
			this.removeChild(tips);
			launchPuman();
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
		
		//暂停
		private function onPauseButtonClick(e:Event):void
		{
			pausevV = vVelocity;
			vVelocity = 0;
			vAcceleration = 0;
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			myAcc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			
			blackBg.visible = true;
			continueButton.visible = true;
			restartButton.visible = true;
			exitButton.visible = true;
			continueButton.addEventListener(Event.TRIGGERED, onContinueButton);
			exitButton.addEventListener(Event.TRIGGERED, onExitBtn);
			restartButton.addEventListener(Event.TRIGGERED, onRestartButton);
		}
		
		//重新开始
		private function onRestartButton(e:Event):void
		{
			initialize();
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
			restartButton.removeEventListener(Event.TRIGGERED, onRestartButton);
		}
		
		//退出游戏
		private function onExitBtn(e:Event):void
		{
			myAcc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "mainMenu"}, true));
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
			trace("MainMenu");
		}
		
		//继续游戏
		private function onContinueButton(e:Event):void
		{
			vVelocity = pausevV;
			vAcceleration = 0.5;
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			myAcc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			
			trace("continue");
			blackBg.visible = false;
			continueButton.visible = false;
			restartButton.visible = false;
			exitButton.visible = false;
			
			continueButton.removeEventListener(Event.TRIGGERED, onContinueButton);
		
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
					puman.y += vVelocity;
					
					if (puman.y > 1000)
					{
						//初始化puman
						vVelocity = -20;
					}
					else
					{
						gameState = "flying";
					}
					break;
				case "flying": 
					puman.x += xSpeed;
					
					vVelocity += vAcceleration;
					
					//if (puman.x = 0)
					//puman.x = 720;
					//if (puman.x = 720)
					//puman.x = 0;
					
					if ((puman.y > middleScreen * 0.25) && (vVelocity < 0))
					{
						//屁孩上升
						puman.y += vVelocity;
					}
					else
					{
						if (vVelocity > 0)
						{
							// 屁孩在下降的话
							puman.y += vVelocity;
						}
						else
						{
							// 当屁孩在中间的时候，游戏背景倒退
							
							//for (var j:int = 0; j < 5; j++)
							//{
							//tmpMc = myVect[j];
							//tmpMc.y -= vVelocity;
							//}
							
							//分数增加
							liveScore += 5;
								//theScore.text = liveScore.toString();
						}
					}
					
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
			puman.y = 1150;
			gameState = "idle";
			vAcceleration = 0.5;
			
			myAcc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		//重力控制
		// MONITOR THE ACCELEROMETER
		
		function onAccUpdate(evt:AccelerometerEvent):void
		{
			accX = -evt.accelerationX;
			if (accX > 0)
			{
				xSpeed += accX * 10 + 1;
			}
			else
			{
				xSpeed += accX * 10 - 1;
			}
			
			if (xSpeed > 5)
			{
				xSpeed = 5;
			}
			if (xSpeed < -5)
			{
				xSpeed = -5;
			}
		}
		
		//触摸控制
		private function onTouch(e:TouchEvent):void
		{
			vVelocity = -20;
		}
	
	}

}