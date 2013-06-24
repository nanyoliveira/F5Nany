package br.com.ef5.ariane.crushTheLadyBug.object {
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
		public function LadyBug() {
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		private function onAddedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			creatLadyBugArt();
		}

		private function creatLadyBugArt() : void {
			
			_ladyBugArt = new MovieClip(Supplies.getAtlas().getTextures("explode_"), 20);
			_ladyBugArt.x = Math.ceil(-_ladyBugArt.width/2);
			_ladyBugArt.y = Math.ceil(-_ladyBugArt.height/2);
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
