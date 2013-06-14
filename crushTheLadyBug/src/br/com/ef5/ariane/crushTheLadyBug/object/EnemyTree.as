package br.com.ef5.ariane.crushTheLadyBug.object {
	import starling.core.Starling;

	import br.com.ef5.ariane.crushTheLadyBug.Supplies;

	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Ariane Oliveira
	 */
	public class EnemyTree extends Sprite {
		private var enemyArt : MovieClip;

		public function EnemyTree() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		private function onAddedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);

			creatEnemytArt();
		}

		private function creatEnemytArt() : void {
			enemyArt = new MovieClip(Supplies.getAtlas().getTextures("enemy_trhee"), 20);
			enemyArt.x = Math.ceil(-enemyArt.width / 2);
			enemyArt.y = Math.ceil(-enemyArt.height / 2);

			Starling.juggler.add(enemyArt);
			addChild(enemyArt);
		}
	}
}
