package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import screens.Welcome;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	
	[SWF(frameRate="60",width="720",height="1280",backgroundColor="0x333333")]
	
	public class Startup extends Sprite
	{
		private var _st:Starling;
		
		public function Startup():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//自适应屏幕分辨率
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			
			_st = new Starling(Game, stage, viewPort);
			_st.stage.stageWidth = 720;
			_st.stage.stageHeight = 1280;
			
			
			_st.showStats = true;
			_st.simulateMultitouch = false;
			_st.antiAliasing = 1;
			
			_st.start();
		}
	
	}

}