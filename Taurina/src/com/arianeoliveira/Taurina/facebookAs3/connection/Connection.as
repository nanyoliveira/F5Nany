package com.arianeoliveira.Taurina.facebookAs3.connection {
	import com.facebook.graph.data.FacebookAuthResponse;
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	import com.arianeoliveira.Taurina.facebookAs3.config.AppInfo;

	import flash.external.ExternalInterface;

	/**
	 * @author aoliveira
	 */
	public class Connection {
		private var _connectecCallBack : Function;
		private var _loginCallBack : Function;

		public function Connection() {
			_connectecCallBack = null;

			if (ExternalInterface.available) {
				Facebook.init(AppInfo.APP_ID, initCallback);
			} else {
				MonsterDebugger.trace("external interface is not available", "");
			}
			
		}

		public function  shootLogin() : void {
			logIn();
		}

		public function  logOut() : void {
			Facebook.logout(onLogOut);
		}

		private function onLogOut($result : Object, $fail : Object) : void {
			if ($result) {
				MonsterDebugger.trace($result, " $result");
				MonsterDebugger.trace($result, $result);
			}

			if ($fail) {
				MonsterDebugger.trace($fail, " $fail");
				MonsterDebugger.trace($fail, $fail);
			}
		}

		public function set connectedCallBack($fn : Function) : void {
			_connectecCallBack = $fn;
		}
		public function set loginCallBack($fn : Function) : void {
			_loginCallBack = $fn;
		}

		protected function initCallback($result : Object, $fail : Object) : void {
			if ($result) {
				AppInfo.FACEBOOK_AUTH_RESPONSE = $result as FacebookAuthResponse;
			}
			_connectecCallBack();
			MonsterDebugger.trace($fail, "THE FAULT - connectedCallBack");
			
		}

		private function logIn() : void {
			Facebook.login(onLogIn, AppInfo.APP_PERMISSIONS);
		}

		private function onLogIn($result : *, $fail : *) : void {
			_loginCallBack();
		}
	}
}
