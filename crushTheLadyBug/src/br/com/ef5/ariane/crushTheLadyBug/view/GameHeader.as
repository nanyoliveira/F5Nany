package br.com.ef5.ariane.crushTheLadyBug.view {
	import br.com.ef5.ariane.crushTheLadyBug.Supplies;

	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Quad;

	import feathers.controls.Button;

	import starling.display.DisplayObject;

	import feathers.controls.Header;

	import starling.text.TextField;

	/**
	 * @author Ariane Oliveira
	 */
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="ShowHome",type="starling.events.Event")]
	public class GameHeader extends Header {
		private var logoImg : Image;
		private static const SHOW_HOME : String = "ShowHome";
		private var _backButton : Button;
		private var backButtonImage : Image;
		private var headerChildren : Vector.<DisplayObject>;
		private var headerRightChildren : Vector.<DisplayObject>;
		private var pontuationScore : TextField;

		public function GameHeader() {
			this._backButton = new Button();
			this._backButton.label = "";
			backButtonImage = new Image(Supplies.getTexture("backButton"));
			_backButton.defaultIcon = backButtonImage;
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			headerChildren = new Vector.<DisplayObject>();
			headerChildren[0] = this._backButton;
			setScore(0);
			this.leftItems = headerChildren;

			var bgQuad : Quad = new Quad(10, 10);
			bgQuad.alpha = 0.1;
			bgQuad.color = 0xaa0000;
			this.backgroundSkin = bgQuad;
		}

		override protected function draw() : void {
			super.draw();

			logoImg = new Image(Supplies.getTexture("title"));
			logoImg.x = (stage.stageWidth - logoImg.width) / 2;
			logoImg.y = ((stage.stageHeight * 0.2) - logoImg.height) / 2;
			addChild(logoImg);
		}

		private function backButton_triggeredHandler(event : Event) : void {
			(parent as GameView).onStop();
			this.parent.dispatchEventWith(SHOW_HOME);
		}

		
		public function distroy() : void {
			this._backButton.removeEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			removeChild(logoImg);
			this.leftItems = null;
			this.rightItems = null;
			this.backgroundSkin = null;
		}

		public function setScore($score : int) : void {
			if (!pontuationScore) {
				pontuationScore = new TextField(30, 40, $score + "");
				pontuationScore.fontSize = 20;
				pontuationScore.color = 0xffffff;
				headerRightChildren = new Vector.<DisplayObject>();
				headerRightChildren[0] = this.pontuationScore;
				this.rightItems = headerRightChildren;
			}
			pontuationScore.text = $score + "";
		}
	}
}
