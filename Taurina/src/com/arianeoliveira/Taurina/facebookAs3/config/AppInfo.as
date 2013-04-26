package com.arianeoliveira.Taurina.facebookAs3.config {
	import com.facebook.graph.data.FacebookAuthResponse;
	/**
	 * @author aoliveira
	 */
	public class AppInfo {
		private static var app_id:String = "";
		private static var app_secret : String ;
		private static var app_permissions : Object  = {scope:""};
		public static var FACEBOOK_AUTH_RESPONSE :FacebookAuthResponse;
		public static const options:Object = {status:true, appId:AppInfo.APP_ID, oauth:true};
		
		public static function set APP_ID($appId:String):void
		{
			if(app_id == "" || app_id== null)
			{
				app_id = $appId;
			}
		}
		
		public static function get APP_SECRET():String{
			return app_secret;
		}
		
		public static function set APP_SECRET($appsecret:String):void
		{
			if(app_secret == "" || app_secret== null)
			{
				app_secret = $appsecret;
			}
		}
		
		public static function get APP_PERMISSIONS():Object
		{
			return app_permissions;
		}
		
		public static function set APP_PERMISSION($permissions:String):void
		{
			if(app_permissions.scope == "" || app_permissions.scope == null)
			{
				app_permissions = {scope:$permissions};
			}
		}
		
		public static function get APP_ID():String{
			return app_id;
		}
	}
}
