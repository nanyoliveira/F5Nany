package com.arianeoliveira.Taurina.outings {
	import nid.dip.AdvancedPNGEncoder;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * @author aoliveira
	 */
	public class DisplayTransformer {
		private static var bitMap : BitmapData;
		public static function transformToBitmapData($display:Sprite, $rectangle:Rectangle, $scaleDisplay:Number = 1):BitmapData
		{
			
			bitMap = new BitmapData($rectangle.width, $rectangle.height);
			var matrix:Matrix = new Matrix();
			matrix.scale($scaleDisplay, $scaleDisplay);
			matrix.tx = $rectangle.x;
			matrix.ty = $rectangle.y;
					
			bitMap.draw($display, matrix, new ColorTransform(), 'normal', new Rectangle(0, 0, $rectangle.width, $rectangle.height), true);
			return bitMap;
		}
		
		public static function convertToPNG($bitMapData:BitmapData):ByteArray
		{
			return AdvancedPNGEncoder.encode($bitMapData,  150);
		}
		
		public static function convertToJPG($bitMapData:BitmapData, $quality:int = 100):ByteArray
		{
			var jpgEncoder:JPGEncoder = new JPGEncoder($quality);
			return jpgEncoder.encode($bitMapData);
		}
	}
}
