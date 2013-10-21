package br.com.ef5.ariane.crushTheLadyBug.view {
	import br.com.ef5.ariane.crushTheLadyBug.object.Grass;
	import br.com.ef5.ariane.crushTheLadyBug.object.LadyBug;

	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;

	import starling.events.TouchEvent;

	
	/**
	 * @author Ariane Oliveira
	 */
	public class GameView extends Screen {
		
		private var _header : GameHeader;
		private var container : ScrollContainer;
		private var ladyBug : LadyBug;
		private var grassBg : Grass;
		private const numberOfEnemy : Number = 15;
		private var score : int;
		
		private var headSize : Number;

		public function GameView() {
			super();
		}

		override protected function initialize() : void {
			setLayout();
			startGame();
			setHeader();
			
		}

		private function onTouched(event : TouchEvent) : void {
			trace("touched screen");
			SquashEnemy();
		}

		private function setLayout() : void {
			const _layout : HorizontalLayout = new HorizontalLayout();

			container = new ScrollContainer();
			container.layout = _layout;

			this.container.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.container.scrollerProperties.snapScrollPositionsToPixels = true;

			addChild(container);

			grassBg = new Grass();
			grassBg.addEventListener(TouchEvent.TOUCH, onTouched);
			addChild(grassBg);

			headSize = stage.stageHeight * 0.2;
			// enemy
			
//			for (var j : int = 0; j < numberOfEnemy; j++) {
//				var enemyTree : Enemy = new EnemyTree();
////				enemyTree.x = (Math.random() * stage.stageWidth) + enemyTree.width;
//				enemyTree.x = (Math.random() * stage.stageWidth) ;
//				enemyTree.y = (Math.random() * stage.stageHeight);
//				enemyTree.onSquashed = SquashEnemy;
//				addChild(enemyTree);
//			}
			
		}

		private function SquashEnemy() : void {
			score-=2;
			if(score< 0)
			{
				score = 0;
			}
			_header.setScore(score);
		}

		override protected function draw() : void {
			this._header.width = this.actualWidth;
			this._header.height = headSize;
			this._header.validate();

			this.container.y = this._header.height;
			this.container.width = this.actualWidth;
			this.container.height = this.actualHeight - this.container.y;

			this.grassBg.width = this.actualWidth;
			this.grassBg.height = this.actualHeight - this.grassBg.y;
		}

		private function setHeader() : void {
			// set header
			_header = new GameHeader();
			_header.title = "Crush The LadyBug";
			addChild(_header);

		}

		private function startGame() : void {
			ladyBug = new LadyBug();
			ladyBug.x = stage.stageWidth / 2;
			ladyBug.y = stage.stageHeight / 2;

			addChild(ladyBug);

			score = 0;

			ladyBug.squashedFunction = onScored;
		}
		
		public function onStop():void
		{
			ladyBug.stop();
			_header.distroy();
			addChild(ladyBug);
			addChild(_header);
			grassBg.removeEventListener(TouchEvent.TOUCH, onTouched);
		}

		private function onScored() : void {
			score++;
			_header.setScore(score);
		}
		
		
	}
}
