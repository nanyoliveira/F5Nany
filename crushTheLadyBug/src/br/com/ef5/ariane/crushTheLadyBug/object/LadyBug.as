package br.com.ef5.ariane.crushTheLadyBug.object {
	import flash.text.engine.ElementFormat;
	import starling.animation.Transitions;
	import starling.animation.Tween;

	import br.com.ef5.ariane.crushTheLadyBug.control.Vibrate;

	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;

	import br.com.ef5.ariane.crushTheLadyBug.Supplies;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author Ariane Oliveira
	 */
	public class LadyBug extends Sprite {
		private var _ladyBugArt : MovieClip;
		private var _squasedFunction : Function;
		private var tween : Tween;
		private var counter : int;
		private var showingTime : int;

		public function LadyBug() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		private function onAddedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);

			creatLadyBugArt();
			setListener();
		}

		private function setListener() : void {
			showingTime = 50;
			counter = 0;
			this.touchable = true;
			this.addEventListener(TouchEvent.TOUCH, squashLadyBug);
			this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function squashLadyBug(event : TouchEvent) : void {
			var touch : Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch) {
				this.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				this.removeEventListener(TouchEvent.TOUCH, squashLadyBug);

				_ladyBugArt.play();
				_ladyBugArt.addEventListener(Event.COMPLETE, onAnimationEnds);

				Vibrate.getInstance().doVibration(50);

				_squasedFunction();

				showingTime--;
				if(showingTime < 7)
				{
					showingTime = 7;
				}
				trace('showingTime: ' + (showingTime));
				counter = 0;
			}
			else
			{
				trace("not LadyBug");
			}
		}

		private function onAnimationEnds(event : Event) : void {
			if (hasEventListener(Event.ENTER_FRAME) == false) {
				this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				trace("added listener");
			}
			
			
		}

		private function onEnterFrameHandler(event : Event) : void {
			if (counter > showingTime) {
				counter = 0;
				mooveLadyBug();
			}
			counter++;
		}

		public function set squashedFunction($fn : Function) : void {
			_squasedFunction = $fn;
		}

		private function mooveLadyBug() : void {
			if(!this.hasEventListener(TouchEvent.TOUCH))
			{
				this.addEventListener(TouchEvent.TOUCH, squashLadyBug);
			}
			
			
			tween = new Tween(this, .2, Transitions.EASE_IN_OUT);
			tween.animate("x", (Math.random() * stage.stageWidth));
			tween.animate("y", (Math.random() * stage.stageHeight));
			Starling.juggler.add(tween);
			_ladyBugArt.currentFrame = 1;
			_ladyBugArt.stop();
		}

		private function creatLadyBugArt() : void {
			_ladyBugArt = new MovieClip(Supplies.getAtlas().getTextures("explode_"), 20);
			_ladyBugArt.x = Math.ceil(-_ladyBugArt.width / 2);
			_ladyBugArt.y = Math.ceil(-_ladyBugArt.height / 2);
			_ladyBugArt.loop = false;
			_ladyBugArt.stop();
			Starling.juggler.add(_ladyBugArt);

			addChild(_ladyBugArt);
		}

		public function get ladyBugArt() : MovieClip {
			return _ladyBugArt;
		}
	}
}
