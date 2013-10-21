package br.com.ef5.ariane.crushTheLadyBug {
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import flash.utils.Dictionary;
	/**
	 * @author Ariane Oliveira
	 */
	public class Supplies {
		[Embed(source="asset/graphics/startBg.png")]
		public static const startBg : Class;

		[Embed(source="asset/graphics/playButton.png")]
		public static const playButton : Class;

		[Embed(source="asset/graphics/backButton.png")]
		public static const backButton : Class;

		[Embed(source="asset/graphics/title.png")]
		public static const title : Class;
		
		[Embed(source="asset/sprite/ladyBug.png")]
		public static const AtlasGestureGame : Class;
		
		[Embed(source="asset/sprite/ladyBug.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame : Class;
		
		private static var gameTexture:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		
		public static function getTexture($name:String):Texture
		{
			if(gameTexture[$name] == undefined)
			{
				var bitmap:Bitmap = new Supplies[$name]();
				gameTexture[$name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTexture[$name];
		}
		
		
		
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasGestureGame");
				var xml:XML = new XML(new AtlasXmlGame());
				
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
	}
}
