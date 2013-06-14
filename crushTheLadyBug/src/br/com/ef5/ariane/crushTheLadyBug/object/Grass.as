package br.com.ef5.ariane.crushTheLadyBug.object {
	import br.com.ef5.ariane.crushTheLadyBug.Supplies;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Ariane Oliveira
	 */
	public class Grass extends Sprite {
		private var grassArt : MovieClip;
		public function Grass() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		private function onAddedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);

			creatGrassArt();
		}

		private function creatGrassArt() : void {
			grassArt = new MovieClip(Supplies.getAtlas().getTextures("background"), 20);
	
			grassArt.x = 0;
			grassArt.y = 0;
			Starling.juggler.add(grassArt);

			addChild(grassArt);
		}
	}
}
