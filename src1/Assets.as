package  
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author SHENGbanX
	 */
	
	public class Assets
	{
		/**
		 * Texture Atlas 
		 */
		[Embed(source="../assets/graphics/mySprite.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../assets/graphics/mySprite.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		/**
		 * Background Assets 
		 */
		//[Embed(source="../assets/graphics/bgLayer1.jpg")]
		//public static const BgLayer1:Class;
		
		[Embed(source="../assets/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		/**
		 * Texture Cache 
		 */
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
	}
}