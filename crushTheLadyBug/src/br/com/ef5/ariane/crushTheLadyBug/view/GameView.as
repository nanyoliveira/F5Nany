package br.com.ef5.ariane.crushTheLadyBug.view {
	import com.gamua.flox.Flox;
	import br.com.ef5.ariane.crushTheLadyBug.object.Enemy;
	import br.com.ef5.ariane.crushTheLadyBug.object.EnemyArk;
	import br.com.ef5.ariane.crushTheLadyBug.object.EnemyStone;
	import br.com.ef5.ariane.crushTheLadyBug.object.EnemyTree;
	import br.com.ef5.ariane.crushTheLadyBug.object.Grass;
	import br.com.ef5.ariane.crushTheLadyBug.object.LadyBug;

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;

	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextField;

	import com.adobe.nativeExtensions.Vibration;

	[Event(name="complete",type="starling.events.Event")]
	[Event(name="ShowHome",type="starling.events.Event")]
	/**
	 * @author Ariane Oliveira
	 */
	public class GameView extends Screen {
		private static const SHOW_HOME : String = "ShowHome";
		private var _header : Header;
		private var _backButton : Button;
		private var headerChildren : Vector.<DisplayObject>;
		private var container : ScrollContainer;
		private var ladyBug : LadyBug;
		private var grassBg : Grass;
		private const numberOfEnemy : Number = 12;
		private var score : int;
		private var pontuationScore : TextField;
		private var headerRightChildren : Vector.<DisplayObject>;

		public function GameView() {
			super();
		}

		override protected function initialize() : void {
			setLayout();
			startGame();
			setHeader();
			
			Flox.logEvent("GameStarted");
		}

		private function setLayout() : void {
			const _layout : HorizontalLayout = new HorizontalLayout();

			container = new ScrollContainer();
			container.layout = _layout;

			this.container.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.container.scrollerProperties.snapScrollPositionsToPixels = true;

			addChild(container);

			grassBg = new Grass();
			addChild(grassBg);

			// enemy
			for (var i : int = 0; i < numberOfEnemy; i++) {
			

				var enemyStone : Enemy = new EnemyStone();
//				enemyStone.x = (Math.random() * stage.stageWidth) + enemyStone.width;
				enemyStone.x = (Math.random() * stage.stageWidth) ;
				enemyStone.y = (Math.random() * stage.stageHeight);
				enemyStone.onSquashed = SquashEnemy;
				addChild(enemyStone);

				var enemyArk : Enemy = new EnemyArk();
//				enemyArk.x = (Math.random() * stage.stageWidth) + enemyArk.width;
				enemyArk.x = (Math.random() * stage.stageWidth) ;
				enemyArk.y = (Math.random() * stage.stageHeight);
				enemyArk.onSquashed = SquashEnemy;
				addChild(enemyArk);
				
			}
			
			for (var j : int = 0; j < numberOfEnemy; j++) {
				var enemyTree : Enemy = new EnemyTree();
//				enemyTree.x = (Math.random() * stage.stageWidth) + enemyTree.width;
				enemyTree.x = (Math.random() * stage.stageWidth) ;
				enemyTree.y = (Math.random() * stage.stageHeight);
				enemyTree.onSquashed = SquashEnemy;
				addChild(enemyTree);
			}
			
		}

		private function SquashEnemy() : void {
			score-=5;
			if(score< 0)
			{
				score = 0;
			}
			setScore();
		}

		override protected function draw() : void {
			this._header.width = this.actualWidth;
			this._header.height = this.actualWidth * 0.10;
			this._header.validate();

			this.container.y = this._header.height;
			this.container.width = this.actualWidth;
			this.container.height = this.actualHeight - this.container.y;

			this.grassBg.width = this.actualWidth;
			this.grassBg.height = this.actualHeight - this.grassBg.y;
		}

		private function setHeader() : void {
			// set header
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			_header = new Header();
			_header.title = "Crush The LadyBug";
			addChild(_header);

			headerChildren = new Vector.<DisplayObject>();
			headerChildren[0] = this._backButton;
			setScore();
			this._header.leftItems = headerChildren;
			this.backButtonHandler = this.onBackButton;
		}

		private function setScore() : void {
			if (!pontuationScore) {
				pontuationScore = new TextField(30, 40, score + "");
				headerRightChildren = new Vector.<DisplayObject>();
				headerRightChildren[0] = this.pontuationScore;
				this._header.rightItems = headerRightChildren;
			}
			pontuationScore.text = score + "";
		}

		private function onBackButton() : void {
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function backButton_triggeredHandler(event : Event) : void {
			this.dispatchEventWith(SHOW_HOME);
		}

		private function startGame() : void {
			ladyBug = new LadyBug();
			ladyBug.x = stage.stageWidth / 2;
			ladyBug.y = stage.stageHeight / 2;

			addChild(ladyBug);

			score = 0;

			ladyBug.squashedFunction = onScored;
		}

		private function onScored() : void {
			score++;
			setScore();
		}
	}
}
