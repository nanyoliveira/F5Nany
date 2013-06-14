package br.com.ef5.ariane.crushTheLadyBug {
	import flash.desktop.NativeApplication;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;

	public class CrushTheLadyBug extends Sprite {
		private var _starling : Starling;
		public function CrushTheLadyBug() {
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.autoOrients = false;
			}
			
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, onCompleteLoader);
		}

		private function onCompleteLoader(event : Event) : void {
			this.loaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoader);
			
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, closeApplication);
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			_starling = new Starling(Main, this.stage);
			_starling.enableErrorChecking = false;
			_starling.simulateMultitouch = true;
			_starling.start();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
			stage.addEventListener(Event.DEACTIVATE, deactivateHandler);
		}

		private function closeApplication(event : Event) : void {
			 NativeApplication.nativeApplication.exit();
		}
		
		private function deactivateHandler(event : Event) : void {
			stage.removeEventListener(Event.DEACTIVATE, deactivateHandler);
			_starling.stop();
			stage.addEventListener(Event.ACTIVATE, activateHandler);
		}
		
		
		private function activateHandler(event : Event) : void {
			stage.removeEventListener(Event.ACTIVATE, activateHandler);
			_starling.start();
		}
		
		private function resizeHandler(event : Event) : void {
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			
			try{
				_starling.viewPort = viewPort;
			}
			catch(e:Error)
			{
				trace("e :" + e);
			}
			
		}
	}
}
