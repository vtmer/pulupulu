package screens
{
	import events.NavigationEvent;
	import starling.display.Button;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.BlendMode;
	import starling.text.TextField;
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
		//private var pu1:Image;
		//private var pu2:Image;
		//private var pu3:Image;
		//private var pu4:Image;
		//private var pu5:Image;
		private var _currenDate:Date;
		private var screenMode:String;
		private var continueBtn:Button;
		private var aboutBtn:Button;
		private var aboutText:TextField;
		private var returnBtn:Button;
		
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
			
			//for (var i:int = 0; i < 5; i++)
			//{
				//pu[i] = new Image(Assets.getAtlas().getTexture("pu"));
				//pu[i].x = 96;
				//pu[i].y = 1260;
				//pu[i].rotation = deg2rad(250);
				//this.addChild(pu[i]);
			//}
			puman = new Image(Assets.getAtlas().getTexture("puman1"));
			puman.x = 220;
			puman.y = 1050;
			this.addChild(puman);
			
			startBtn = new Button(Assets.getAtlas().getTexture("startBtn"));
			startBtn.x = 176;
			startBtn.y = 567;
			startBtn.addEventListener(Event.TRIGGERED, onStartBtnClick);
			this.addChild(startBtn);
			
			//continueBtn = new Button(Assets.getAtlas().getTexture("continueBtn"));
			//continueBtn.x = 176;
			//continueBtn.y = 567;
			//continueBtn.addEventListener(Event.TRIGGERED, onContinueBtnClick)
			//this.addChild(continueBtn);
			
			rankBtn = new Button(Assets.getAtlas().getTexture("rankBtn"));
			rankBtn.x = 176;
			rankBtn.y = 729;
			rankBtn.addEventListener(Event.TRIGGERED, onRankBtnClick);
			this.addChild(rankBtn);
			
			aboutBtn = new Button(Assets.getAtlas().getTexture("aboutBtn"));
			aboutBtn.x = 176;
			aboutBtn.y = 885;
			aboutBtn.addEventListener(Event.TRIGGERED, onAboutBtnClick);
			this.addChild(aboutBtn);
			
			aboutText = new TextField(720, 900, "", "Verdana", 40);
			aboutText.text = "操作方法：\n移动设备上使用重力感应控制左右\n电脑上使用A和D键控制左右\n触摸或鼠标点击放屁飞跃。\n有节制地放屁并通过食物补充屁能\n使角色飞得更高吧！\n\n" + "制作人员：\n策划：ck、bobo\n程序：sheng、ms\n美工：yan0\n设计：ck\n总监：sheng\n\n" + "@2013维生数工作室VTMER"
			this.addChild(aboutText);
			aboutText.visible = false;
			
			returnBtn = new Button(Assets.getAtlas().getTexture("returnBtn"));
			returnBtn.x = 175;
			returnBtn.y = 885;
			returnBtn.addEventListener(Event.TRIGGERED, onReturnBtnClick);
			this.addChild(returnBtn);
			returnBtn.visible = false;
		}
		
		private function onReturnBtnClick(e:Event):void
		{
			returnBtn.visible = false;
			aboutText.visible = false;
			puman.visible = true;
			pu.visible = true;
			title.visible = true;
			aboutBtn.visible = true;
			startBtn.visible = true;
			rankBtn.visible = true;
		}
		
		private function onContinueBtnClick(e:Event):void
		{
		
		}
		
		private function onAboutBtnClick(e:Event):void
		{
			showAbout();
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
			returnBtn.visible = true;
			aboutText.visible = true;
			puman.visible = false;
			pu.visible = false;
			title.visible = false;
			aboutBtn.visible = false;
			startBtn.visible = false;
			rankBtn.visible = false;
		}
		
		public function showWelcomeScreen():void
		{
			this.addEventListener(Event.ENTER_FRAME, puAnimation);
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