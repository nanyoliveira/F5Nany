package com.arianeoliveira.Taurina.facebookAs3.events {
	import flash.events.Event;

	/**
	 * @author aoliveira
	 */
	public class FacebookEvents extends Event {
		
		public static const LOGIN_DATA_AVAILABLE : String = "LOGIN_DATA_AVAILABLE";
		public static const LOGIN_READY : String = "LOGIN_READY";
		public static const POST_PHOTO_DATA_AVAILABLE : String = "POST_PHOTO_DATA_AVAILABLE";
		public static const POST_PHOTO_FAIL : String = "POST_PHOTO_FAIL";
		public static const POST_PHOTO_MESSAGE_DATA_AVAILABLE : String = "POST_PHOTO_MESSAGE_DATA_AVAILABLE";
		public static const POST_PHOTO_MESSAGE_FAIL : String = "POST_PHOTO_MESSAGE_FAIL";
		public static const POST_MESSAGE_DATA_AVAILABLE : String = "POST_MESSAGE_DATA_AVAILABLE";
		public static const POST_MESSAGE_FAIL : String = "POST_MESSAGE_FAIL";
		
		private var _data : *;
		
		public function FacebookEvents(type : String, $data:*) {
			super(type, true, true);
			_data = $data;
		}
		
		public function get data() : *
		{
			return _data;
		}
		
		override public function clone() : Event 
		{
			return new FacebookEvents(type, data);
		}
	}
}



