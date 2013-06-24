package br.com.ef5.ariane.crushTheLadyBug.view {
	import br.com.ef5.ariane.crushTheLadyBug.control.Vibrate;
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

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

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
		private const numberOfEnemy : Number = 2;
		private var counter : int;
		private var showingTime : int;
		private var tween : Tween;
		private var score : int;
		private var vibration : Vibration;

		public function GameView() {
			super();
		}

		override protected function initialize() : void {
			setLayout();
			startGame();
			setHeader();
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
				var enemyTree : Enemy = new EnemyTree();
				enemyTree.x = (Math.random() * stage.stageWidth) + enemyTree.width;
				enemyTree.y = (Math.random() * stage.stageHeight);
				addChild(enemyTree);

				var enemyStone : Enemy = new EnemyStone();
				enemyStone.x = (Math.random() * stage.stageWidth) + enemyStone.width;
				enemyStone.y = (Math.random() * stage.stageHeight);
				addChild(enemyStone);

				var enemyArk : Enemy = new EnemyArk();
				enemyArk.x = (Math.random() * stage.stageWidth) + enemyArk.width;
				enemyArk.y = (Math.random() * stage.stageHeight);
				addChild(enemyArk);
			}
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
			this._header.leftItems = headerChildren;
			this.backButtonHandler = this.onBackButton;
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
			ladyBug.touchable = true;
			ladyBug.addEventListener(TouchEvent.TOUCH, squashLadyBug);
			addChild(ladyBug);

			showingTime = 50;
			counter = 0;
			score = 0;

			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onEnterFrameHandler(event : Event) : void {
			if (counter > showingTime) {
				counter = 0;
				mooveLadyBug();
			}

			counter++;
		}

		private function squashLadyBug(event : TouchEvent) : void {
			var touch : Touch = event.getTouch(ladyBug, TouchPhase.BEGAN);
			if (touch) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				ladyBug.ladyBugArt.play();
				// score
				score++;
				showingTime--;
				counter = 0;
				Vibrate.getInstance().doVibration(50);
				if (hasEventListener(Event.ENTER_FRAME) == false) {
					addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					trace("added listener");
				}
			}
		}

		private function mooveLadyBug() : void {
			tween = new Tween(ladyBug, .2, Transitions.EASE_IN_OUT);
			tween.animate("x", (Math.random() * stage.stageWidth));
			tween.animate("y", (Math.random() * stage.stageHeight));
			Starling.juggler.add(tween);
			ladyBug.ladyBugArt.currentFrame = 1;
			ladyBug.ladyBugArt.stop();
		}
	}
}
