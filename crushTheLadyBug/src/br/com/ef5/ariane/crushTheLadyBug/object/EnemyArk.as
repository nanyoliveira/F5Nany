package br.com.ef5.ariane.crushTheLadyBug.object {
	import br.com.ef5.ariane.crushTheLadyBug.Supplies;

	import starling.core.Starling;
	import starling.display.MovieClip;

	/**
	 * @author Ariane Oliveira
	 */
	public class EnemyArk extends Enemy {
		
		public function EnemyArk() {
			super();
		}

		override protected function creatEnemytArt() : void {
			enemyArt = new MovieClip(Supplies.getAtlas().getTextures("enemy_earth"), 20);
			enemyArt.x = Math.ceil(-enemyArt.width / 2);
			enemyArt.y = Math.ceil(-enemyArt.height / 2);
			
			enemyArt.scaleX = enemyArt.scaleY = .5;

			Starling.juggler.add(enemyArt);
			addChild(enemyArt);
		}
	}
}
