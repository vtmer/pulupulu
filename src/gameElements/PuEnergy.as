package gameElements
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * 屁能（遮罩）
	 *
	 * @author SHENGbanX
	 */
	public class PuEnergy extends Sprite
	{
		private var puEnergyArt1:Image;
		private var puEnergyArt2:Image;
		private var mRatio:Number;
		private var xRatio:Number;
		
		public function PuEnergy()
		{
			super();
			mRatio = 1;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			createPuEnergyArt();
		}
		
		private function createPuEnergyArt():void
		{
			puEnergyArt1 = new Image(Assets.getAtlas().getTexture("puEnergy1"));
			this.addChild(puEnergyArt1);
			
			puEnergyArt2 = new Image(Assets.getAtlas().getTexture("puEnergy2"));
			puEnergyArt2.pivotY = puEnergyArt2.height;
			puEnergyArt2.y=puEnergyArt2.height;
			this.addChild(puEnergyArt2);
		
		}
		
		private function update():void
		{
			puEnergyArt2.scaleY = mRatio;
			//修正让缩放时对齐底部
			//puEnergyArt2.y= puEnergyArt2.height * xRatio*2;
			//puEnergyArt2.y = puEnergyArt2.height / puEnergyArt2.scaleY * xRatio;
			puEnergyArt2.setTexCoords(0, new Point(0.0, xRatio));
			puEnergyArt2.setTexCoords(1, new Point(1.0, xRatio));
		
		}
		
		public function get ratio():Number
		{
			return mRatio;
		}
		
		public function set ratio(value:Number):void
		{
			mRatio = Math.max(0.0, Math.min(1.0, value));
			xRatio = -mRatio + 1.0;
			update();
		}
	
	}

}