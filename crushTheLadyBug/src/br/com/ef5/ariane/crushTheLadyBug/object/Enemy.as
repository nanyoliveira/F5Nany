package br.com.ef5.ariane.crushTheLadyBug.object {
	import br.com.ef5.ariane.crushTheLadyBug.control.Vibrate;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * @author Usuario
	 */
	public class Enemy extends Sprite {
		protected var enemyArt : MovieClip;
		public function Enemy() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		protected function onAddedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			
			
			creatEnemytArt();
			this.addEventListener(TouchEvent.TOUCH, squashEnemy);
		}

		protected function creatEnemytArt() : void {
			
		}
		
		private function squashEnemy($event : TouchEvent) : void {
			
			var touch : Touch = $event.getTouch(enemyArt, TouchPhase.BEGAN);
			if (touch) {
				Vibrate.getInstance().doVibration(700);
				loosePoints();
			}
		}
		
		private function loosePoints() : void {
		}

		
		
		
		
	}
}
