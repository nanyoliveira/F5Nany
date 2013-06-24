package br.com.ef5.ariane.crushTheLadyBug.control {
	import com.adobe.nativeExtensions.Vibration;

	/**
	 * @author Usuario
	 */
	public class Vibrate {
		private static var instance : Vibrate;
		private var vibration : Vibration;

		public function Vibrate() {
			if (Vibration.isSupported) {
				vibration = new Vibration();
			}
		}

		public static function getInstance() : Vibrate {
			if (instance == null) {
				instance = new Vibrate();
			}

			return instance;
		}

		public function doVibration($duration : Number) : void {
			if (vibration) {
				vibration.vibrate($duration);
			}
		}
	}
}
