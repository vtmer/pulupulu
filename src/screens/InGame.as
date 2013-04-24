package screens
{
	import events.NavigationEvent;
	import flash.events.AccelerometerEvent;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import gameElements.GameProps;
	import gameElements.Pu;
	import gameElements.PuEnergy;
	import gameElements.Puman;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		private var pausexS:Number;
		private var pu:Pu;
		private var gameProps:GameProps;
		private var propsVect:Vector.<Sprite>=new Vector.<Sprite>(10,true);
		private var props:Sprite;
		
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
			pausexS = xSpeed;
			xSpeed = 0;
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
			xSpeed = pausexS;
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
					
					if (puman.x < 0)
						puman.x = 720;
					if (puman.x > 720)
						puman.x = 0;
								
					//碰撞道具
					for (var i:int = 0; i < 10; i++)
					{
						props = propsVect[i];
						//if (puman.hitTestObject(props)
					}	
								
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
							// 游戏背景倒退
							
							for (var j:int = 0; j < 10; j++)
							{
							props = propsVect[j];
							props.y -= vVelocity;
							}
							
							//分数增加
							liveScore += 5;
								//theScore.text = liveScore.toString();
						}
					}
					
					if (propsVect[0] != null)
					{
						for (var k:int = 0; k < 10; k++)
						{
							props = propsVect[k];
							if (props.y > 1280) {
							props.y = -5;
							props.x = Math.random() * stage.stageWidth;
							}
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
			puman.x = 360;
			gameState = "idle";
			vAcceleration = 0.5;
			
			liveScore = 0;
			accX = 0;
			
			for (var i:int = 0; i < 10; i++)
			{
				gameProps = new GameProps();
				gameProps.x = Math.random() * stage.stageWidth;
				gameProps.y = 100 + (i * stage.stageHeight / 6-100);
				
				propsVect[i] = gameProps;
				addChild(gameProps);
			}
			
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
			var touch:Touch = e.getTouch(stage);
			if (touch.phase == "ended")
			{
				vVelocity = -20;
				pu = new Pu();
				pu.x = puman.x;
				pu.y = puman.y + puman.height;
				this.addChild(pu);
			}
		}
	
	}

}