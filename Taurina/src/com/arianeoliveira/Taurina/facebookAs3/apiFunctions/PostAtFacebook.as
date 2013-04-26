package com.arianeoliveira.Taurina.facebookAs3.apiFunctions {
	import com.arianeoliveira.Taurina.facebookAs3.FacebookAS3;
	import com.arianeoliveira.Taurina.facebookAs3.events.FacebookEvents;
	import flash.utils.ByteArray;
	import com.facebook.graph.Facebook;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * @author aoliveira
	 */
	public class PostAtFacebook {
		/*
		 * 
		 * @params: $photoByteArray - the image byteArray you want to post
		 * @params: $fileName - optional - the name of the image
		 */
		public function postPhoto($photoByteArray : ByteArray, $fileName : String = "minhafoto.png") : void {
			Facebook.api("/me/photos", onPostPhotoDone, {image:$photoByteArray, fileName:$fileName}, "POST");
		}

		private function onPostPhotoDone($result : Object, $fail : Object) : void {
			if ($result) {
				MonsterDebugger.trace($result, " on done post photo - return a success result");
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_PHOTO_DATA_AVAILABLE, $result));
			}

			if ($fail) {
				MonsterDebugger.trace(this, "fail");
				MonsterDebugger.trace(this, $fail);
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_PHOTO_FAIL, $fail));
			}
		}

		/*
		 * @params: $message - the messagem you wanto to goes with the post
		 * @params: $photoByteArray - the image byteArray you want to post
		 * @params: $fileName - optional - the name of the image
		 */
		public function postPhotoWithMessage($message : String, $photoByteArray : ByteArray, $fileName : String = "minhafoto.png") : void {
			Facebook.api("/me/photos", onPostPhotoWithMessageDone, {image:$photoByteArray, fileName:$fileName, message:$message}, "POST");
		}

		private function onPostPhotoWithMessageDone($result : Object, $fail : Object) : void {
			if ($result) {
				MonsterDebugger.trace($result, " on done post photo - return a success result");
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_PHOTO_MESSAGE_DATA_AVAILABLE, $result));
			}

			if ($fail) {
				MonsterDebugger.trace(this, "fail");
				MonsterDebugger.trace(this, $fail);
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_PHOTO_MESSAGE_FAIL, $fail));
			}
		}
		
		
		/*
		 * @params: $message - the messagem you wanto to goes with the post
		 * 
		 */
		public function postMessage($message : String) : void {
			Facebook.api("/me/feed", onpostMessageDone, {message:$message}, "POST");
		}

		private function onpostMessageDone($result : Object, $fail : Object) : void {
			if ($result) {
				MonsterDebugger.trace($result, " on done post photo - return a success result");
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_MESSAGE_DATA_AVAILABLE, $result));
			}

			if ($fail) {
				MonsterDebugger.trace(this, "fail");
				MonsterDebugger.trace(this, $fail);
				FacebookAS3.getInstance().eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.POST_MESSAGE_FAIL, $fail));
			}
		}
		
	}
}
