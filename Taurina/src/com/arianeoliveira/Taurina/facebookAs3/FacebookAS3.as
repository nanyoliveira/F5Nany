package com.arianeoliveira.Taurina.facebookAs3 {
	import com.arianeoliveira.Taurina.facebookAs3.apiFunctions.GetAtFacebook;
	import com.arianeoliveira.Taurina.facebookAs3.apiFunctions.PostAtFacebook;
	import com.arianeoliveira.Taurina.facebookAs3.config.AppInfo;
	import com.arianeoliveira.Taurina.facebookAs3.connection.Connection;
	import com.arianeoliveira.Taurina.facebookAs3.events.FacebookEvents;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;

	[SWF(backgroundColor="#aa00aa", frameRate="31", width="520", height="530")]
	public class FacebookAS3 {
		private static var instance : FacebookAS3;
		private var facebookConnection : Connection;
		private var configSetted : Boolean;
		public var eventShooter : Sprite;
		private var postAtFacebook : PostAtFacebook;
		private var getAtFacebook : GetAtFacebook;

		public function FacebookAS3() {
			MonsterDebugger.initialize(this);
			
			eventShooter = new Sprite();
			
			postAtFacebook = new PostAtFacebook();
			getAtFacebook = new GetAtFacebook();
		}

		public static function getInstance() : FacebookAS3 {
			if (!instance) {
				instance = new FacebookAS3();
			}
			return instance;
		}

		public function init() : void {
			if (configSetted) {
				initConnection();
			} else {
				throw new IllegalOperationError("you must set application configuration first. Set it with the method setConfigurations");
			}
		}

		public function setConfigurations($appId : String, $appSecret : String, $permissions : String) : void {
			AppInfo.APP_ID = $appId;
			AppInfo.APP_SECRET = $appSecret;
			AppInfo.APP_PERMISSION = $permissions;
			configSetted = true;
		}

		public function doLogin() : void {
			facebookConnection.loginCallBack = loginCallBack;
			facebookConnection.shootLogin();
			
		}

		private function loginCallBack() :void {
			eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.LOGIN_READY, null));
		}
		
		public function doLogOut() : void {
			facebookConnection.logOut();
		}
		
		public function destroyAll():void{
			facebookConnection = null;
			AppInfo.APP_ID = "";
			AppInfo.APP_SECRET = "";
			AppInfo.APP_PERMISSION = "";
			AppInfo.FACEBOOK_AUTH_RESPONSE = null;
			configSetted = true;
		}

		protected function initConnection() : void {
            if(facebookConnection)
            {
                facebookConnection.connectedCallBack = null;
                facebookConnection = null;
            }
			
			facebookConnection = new Connection();
			facebookConnection.connectedCallBack = dataAvailable;
		}

		private function dataAvailable() : void {
			MonsterDebugger.trace("dataAvailable", "dataAvailable");
			eventShooter.dispatchEvent(new FacebookEvents(FacebookEvents.LOGIN_DATA_AVAILABLE, AppInfo.FACEBOOK_AUTH_RESPONSE));
		}
		/*
		 * 
		 * @params: $photoByteArray - the image byteArray you want to post
		 * @params: $fileName - optional - the name of the image
		 * @coment: to get a return you should insert a listener at eventShooter
		 */


		public function postPhoto($photoByteArray : ByteArray, $fileName : String = "minhafoto.png") : void {
			postAtFacebook.postPhoto($photoByteArray, $fileName);
		}
		
		/*
		 * @params: $message - the messagem you wanto to goes with the post
		 * @params: $photoByteArray - the image byteArray you want to post
		 * @params: $fileName - optional - the name of the image
		 *  @coment: to get a return you should insert a listener at eventShooter
		 */
		
		public function postPhotoWithMessage($message:String, $photoByteArray : ByteArray, $fileName : String = "minhafoto.png") : void {
			postAtFacebook.postPhotoWithMessage($message, $photoByteArray, $fileName);
		}

		
		
		
	}
}
