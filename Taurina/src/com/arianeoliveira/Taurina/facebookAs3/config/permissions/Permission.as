package com.arianeoliveira.Taurina.facebookAs3.config.permissions {
	/**
	 * @author aoliveira
	 */
	public class Permission {
		public static const read_stream_permission : String = "read_stream";
		public static const publish_stream_permission : String = "publish_stream";
		public static const user_photos_permission : String = "user_photos";
		public static const upload_photos_permission : String = "photo_upload";
		private static var permissions : String = "";

		public static function setPermissions($permission : String) : void {
			if (permissions == "") {
				permissions = $permission;
			} else {
				permissions += ", "+$permission;
			}
		}
		
		public static function allPermissions():String{
			return permissions;
		}
	}
}
