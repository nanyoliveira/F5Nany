package com.arianeoliveira.Taurina.textPackage {
	import flash.text.TextField;

	/**
	 * @author aoliveira
	 */
	public class TextUtils {
		private static var tempTxt : String;
		
		public static function isValidString($string:String):Boolean
		{
			var tempString:String = $string;
			tempString = removeBlankCharacter(tempString);
			if (tempString.length > 0) {
				return true;
			} else {
				return false;
			}
		}

		public static function isNotEmpty($txtArea : TextField) : Boolean {
			tempTxt = $txtArea.text;

			tempTxt = removeBlankCharacter(tempTxt);
			if (tempTxt.length > 0) {
				return true;
			} else {
				return false;
			}
		}

		private static function removeBlankCharacter($string : String) : String {
			var currentText : String = $string;
			var rEx : RegExp = /[\s\r\n]*/gim;
			var finalTempText : String = currentText.replace(rEx, '');
			return finalTempText;
		}
	}
}

