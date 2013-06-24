package br.com.ef5.ariane.crushTheLadyBug.object {
	import br.com.ef5.ariane.crushTheLadyBug.Supplies;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author Ariane Oliveira
	 */
	public class EnemyTree extends Enemy {

		public function EnemyTree() {
			super();
		}

		override protected function creatEnemytArt() : void {
			enemyArt = new MovieClip(Supplies.getAtlas().getTextures("enemy_trhee"), 20);
			enemyArt.x = Math.ceil(-enemyArt.width / 2);
			enemyArt.y = Math.ceil(-enemyArt.height / 2);

			Starling.juggler.add(enemyArt);
			addChild(enemyArt);
		}
	}
}
