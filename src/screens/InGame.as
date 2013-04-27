package screens
{
	import events.NavigationEvent;
	import flash.events.AccelerometerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import gameElements.GameProps;
	import gameElements.Pu;
	import gameElements.PuEnergy;
	import gameElements.Puman;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObject;
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
		private const middleScreen:Number = 640;
		private var tips:TextField;
		private var pausevV:Number;
		private var pausexS:Number;
		private var pu:Pu;
		private var gameProps:GameProps;
		private var propsVect:Vector.<Sprite> = new Vector.<Sprite>(propsNum, true);
		private var props:Sprite;
		private var phase:String;
		private var propsNum:int = 15;
		private var score:TextField;
		private var upEnergy:int = 30;
		private var hitprops:DisplayObject;
		private var object1:DisplayObject;
		private var object2:DisplayObject;
		private var pt1:Point;
		private var hitN:Number = 0;
		private var radius1:Number;
		private var radius2:Number;
		private var p1:Point;
		private var p2:Point;
		private var distance:Number;
		private var myAcc:Accelerometer = new Accelerometer();
		
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
			bg.blendMode = BlendMode.NONE;
			
			gameBar = new Image(Assets.getAtlas().getTexture("gameBar"));
			this.addChild(gameBar);
			
			score = new TextField(200, 50, "0", "Verdana", 40);
			score.x = 0;
			score.y = 0;
			this.addChild(score);
			
			//添加道具
			for (var i:int = 0; i < propsNum; i++)
			{
				gameProps = new GameProps();
				gameProps.x = Math.random() * stage.stageWidth;
				gameProps.y = 100 + (i * stage.stageHeight / (propsNum + 1) - 100);
				
				propsVect[i] = gameProps;
				addChild(gameProps);
			}
			
			puman = new Puman();
			puman.x = 350;
			puman.y = 1290;
			puman.name = "puman";
			this.addChild(puman);
			trace("Puman");
			
			puEnergy = new PuEnergy();
			puEnergy.x = 591;
			puEnergy.y = 85;
			this.addChild(puEnergy);
			
			tips = new TextField(640, 1280, "Touch to play!", "Verdana", 50);
			tips.x = 50;
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
			if (phase == "ended" && puEnergy.ratio > 0.1)
			{
				tips.visible = false;
				launchPuman();
				tips.removeEventListener(TouchEvent.TOUCH, onTouchTips);
			}
		}
		
		private function pauseView():void
		{
			blackBg = new Quad(720, 1280, 0x000000, true);
			blackBg.alpha = .4;
			this.addChild(blackBg);
			
			continueButton = new Button(Assets.getAtlas().getTexture("continueBtn2"));
			continueButton.x = 125;
			continueButton.y = 275;
			this.addChild(continueButton);
			
			restartButton = new Button(Assets.getAtlas().getTexture("restartBtn"));
			restartButton.x = 125;
			restartButton.y = 533;
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
			this.removeEventListener(Event.ENTER_FRAME, onGameState)
			
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
			this.addEventListener(Event.ENTER_FRAME, onGameState)
			
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
			score.text = String(liveScore);
			//游戏状态
			switch (gameState)
			{
				//重力、阻力、加速度？
				case "idle": 
					puman.y += vVelocity;
					
					if (puman.y > 1280)
					{
						//初始化puman
						vVelocity = -upEnergy;
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
					for (var i:int = 0; i < propsNum; i++)
					{
						props = propsVect[i];
						if (HitTest(props, puman))
						{
							trace("hit");
							props.visible = false;
							puEnergy.ratio += 0.01;
						}
						
							//
							//hitprops = props.hitTest(pt1, true);
							//if (hitprops != null){
							//trace(hitprops.name);
							//hitN++;
							//trace(hitN)
							//trace(puman.name);
							//}
						
					}
					
					if ((puman.y > middleScreen) && (vVelocity < 0))
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
							
							for (var j:int = 0; j < propsNum; j++)
							{
								props = propsVect[j];
								props.y -= vVelocity;
							}
							
							//分数增加e
							liveScore += 10;
								//theScore.text = liveScore.toString();
						}
					}
					
					//道具重置复用
					if (propsVect[0] != null)
					{
						for (var k:int = 0; k < Math.floor(propsNum - liveScore / 3000); k++)
						{
							props = propsVect[k];
							if (props.y > 1280)
							{
								props.y = -5;
								props.x = Math.random() * stage.stageWidth;
								props.visible = true;
							}
						}
					}
					
					//死亡判定
					if (puman.y > (1280 + puman.height))
					{
						gameState = "over";
					}
					
					break;
				case "over": 
					score.x = 180;
					score.y = 400;
					score.scaleX = 2;
					score.scaleY = 2;
					myAcc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
					blackBg.visible = true;
					restartButton.visible = true;
					exitButton.visible = true;
					exitButton.addEventListener(Event.TRIGGERED, onExitBtn);
					restartButton.addEventListener(Event.TRIGGERED, onRestartButton);
					break;
			}
		
		}
		
		//碰撞方法
		private function HitTest(object1:DisplayObject, object2:DisplayObject, value:* = null):Boolean
		{
			
			radius1 = object1.width / 2;
			radius2 = object2.width / 2;
			
			p1 = new Point(object1.x, object1.y);
			p2 = new Point(object2.x, object2.y);
			
			distance = Point.distance(p1, p2);
			if (distance < (radius1 + radius2))
			{
				return true;
			}
			else
				return false;
		}
		
		public function initialize():void
		{
			
			//puman.x = -stage.stageWidth * 0.5;
			//puman.y = -stage.stageHeight;
			
			//闲置			
			puman.y = 1290;
			puman.x = 360;
			gameState = "idle";
			vAcceleration = 0.5;
			score.x = 0;
			score.y = 0;
			score.scaleX = 1;
			score.scaleY = 1;
			liveScore = 0;
			
			accX = 0;
			tips.visible = true;
			tips.addEventListener(TouchEvent.TOUCH, onTouchTips);
			
			myAcc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			disposeTemporarily();
			puEnergy.ratio = 1.0;
			
			this.visible = true;
		
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		//重力控制
		// MONITOR THE ACCELEROMETER
		
		private function onAccUpdate(evt:AccelerometerEvent):void
		{
			accX = -evt.accelerationX;
			if (accX > 0)
			{
				xSpeed += accX * 10 + 2;
			}
			else
			{
				xSpeed += accX * 10 - 2;
			}
			
			if (xSpeed > 10)
			{
				xSpeed = 10;
			}
			if (xSpeed < -10)
			{
				xSpeed = -10;
			}
		}
		
		//触摸控制
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			phase = touch.phase;
			if (phase == "ended" && puEnergy.ratio > 0.1)
			{
				vVelocity = -upEnergy;
				pu = new Pu();
				pu.x = puman.x;
				pu.y = puman.y + puman.height;
				this.addChild(pu);
				puEnergy.ratio -= 0.1;
			}
		}
	
	}

}