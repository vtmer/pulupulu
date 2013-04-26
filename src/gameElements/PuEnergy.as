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
		
		public function PuEnergy()
		{
			super();
			mRatio = 0.0;
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
			
			puEnergyArt2= new Image(Assets.getAtlas().getTexture("puEnergy2"));
			this.addChild(puEnergyArt2);
			
			
		}
		
		
		private function update():void
        {   /*if(puEnergyArt.scaleY>0.8)
		    puEnergyArt.scaleY -= mRatio*0.2;*/
            puEnergyArt2.scaleY = mRatio;
            puEnergyArt2. setTexCoords ( 2 ,  new  Point ( 0.0,mRatio));
            puEnergyArt2. setTexCoords ( 3 ,  new  Point ( 1.0,mRatio));
            
        }
		//public function get ratio(){ return mRatio; }
         public function setratio(value:Number):void 
        { mRatio=1.0-value;
		  if(mRatio>0)
          update();
		  
		}
	
	}

}