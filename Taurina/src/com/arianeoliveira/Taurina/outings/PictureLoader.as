package com.arianeoliveira.Taurina.outings {
	import com.demonsters.debugger.MonsterDebugger;

	import flash.errors.IllegalOperationError;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 * @author aoliveira
	 */
	public class PictureLoader {
		private static var instance : PictureLoader;
		private var imageWidth : int;
		private var imageHeight : int;
		private var loader : Loader;
		private var thumbParent : DisplayObjectContainer;
		private var path : String;
		private var byteArray : ByteArray;
		private var _copyByteArray : ByteArray;
		private var _byteArrayEncode : ByteArray;
		private var bitmap : Bitmap;
		private var loaderContext : LoaderContext;
		private var _copiedBitmap : Bitmap;
		private var originalLoader : Loader;
		private var _onImageLoadedAction : Function;

		public function PictureLoader() {
		}

		public function loadFromBytes($byteArray : ByteArray, $mcHolder : DisplayObjectContainer, $rectangleResult : Rectangle) : void {
			byteArray = $byteArray;
			_copyByteArray = $byteArray;
			imageWidth = $rectangleResult.width;
			imageHeight = $rectangleResult.height;
			thumbParent = $mcHolder;
			loadFromByteArray();
		}

		public function loadFromPath($rectangleResult : Rectangle, $path : String, $mcHolder : DisplayObjectContainer) : void {
			path = $path;
			imageWidth = $rectangleResult.width;
			imageHeight = $rectangleResult.height;
			thumbParent = $mcHolder;
			loadFromURL();
		}

		public static function getInstance() : PictureLoader {
			if (instance == null) {
				instance = new PictureLoader();
			}

			return instance;
		}

		private function loadFromByteArray() : void {
			loader = new Loader();
			loader.loadBytes(byteArray);
			originalLoader = new Loader();
			originalLoader.loadBytes(_copyByteArray);

			originalLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onOriginalImageByteArrayLoaded);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageByteArrayLoaded);
		}

		private function onOriginalImageByteArrayLoaded(event : Event) : void {
			_copiedBitmap = originalLoader.content as Bitmap;
		}

		private function onImageByteArrayLoaded(event : Event) : void {
			bitmap = loader.content as Bitmap;
			thumbParent.addChild(loader);

			setImageSize();
		}

		public function get byteArrayEncode() : ByteArray {
			_byteArrayEncode = DisplayTransformer.convertToJPG(_copiedBitmap.bitmapData);
			return _byteArrayEncode;
		}

		private function loadFromURL() : void {
			loader = new Loader();
			loaderContext = new LoaderContext();
			loaderContext.checkPolicyFile = true;

			loader.load(new URLRequest(path), loaderContext);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onThumbImageLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onThumbImageLoadedError);

			thumbParent.addChild(loader);
		}

		private function onThumbImageLoadedError(event : IOErrorEvent) : void {
			MonsterDebugger.trace("Load Photo error", event);
		}

		private function onThumbImageLoaded(event : Event) : void {
			_onImageLoadedAction();
			bitmap = event.target.content as Bitmap;
			setImageSize();
			
		}

		private function setImageSize() : void {
			bitmap.smoothing = true;

			// horizontal image
			if (bitmap.width >= bitmap.height) {
				//image less than container
				if (bitmap.width <= imageWidth) {
					if (bitmap.height > imageHeight) {
						bitmap.height = imageHeight;
						bitmap.scaleX = bitmap.scaleY;
					}
				}
				// image greater than container 
				else {
					bitmap.width = imageWidth;
					bitmap.scaleY = bitmap.scaleX;

					// image height greater than container after width adjustment
					if (bitmap.height > imageHeight) {
						bitmap.height = imageHeight;
						bitmap.scaleX = bitmap.scaleY;
					}
				}
			}
			// vertical image 
			else if (bitmap.height > bitmap.width) {
				if (bitmap.height <= imageHeight) {
					if (bitmap.width > imageWidth) {
						bitmap.width = imageWidth;
						bitmap.scaleY = bitmap.scaleX;
					}
				} else {
					bitmap.height = imageHeight;
					bitmap.scaleX = bitmap.scaleY;

					if (bitmap.width > imageWidth) {
						bitmap.width = imageWidth;
						bitmap.scaleY = bitmap.scaleX;
					}
				}
			}

			bitmap.x = (thumbParent.width - bitmap.width) / 2;

			bitmap.y = (thumbParent.height - bitmap.height) / 2;
			trace('thumbParent.height - bitmap.height: ' + (thumbParent.height - bitmap.height));
			
			_onImageLoadedAction();
		}


		public function destroy() : void {
			if (loader != null) {
				thumbParent.removeChild(loader);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onThumbImageLoaded);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onThumbImageLoadedError);
			}
		}

		public function get copyByteArray() : ByteArray {
			return _copyByteArray;
		}

		public function set onImageLoadedAction($onImageLoadedActionFn : Function) : void {
			_onImageLoadedAction = $onImageLoadedActionFn;
		}
	}
}
