package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import screens.Welcome;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	
	[SWF(frameRate="60",width="720",height="1280",backgroundColor="0x333333")]
	
	public class Startup extends Sprite
	{
		public function Startup():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			var _st:Starling = new Starling(Welcome, stage);
			
			_st.showStats = true;
			_st.simulateMultitouch = false;
			_st.antiAliasing = 1;
			
			_st.start();
		}
	
	}

}