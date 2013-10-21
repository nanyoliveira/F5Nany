package br.com.ef5.ariane.crushTheLadyBug.view {
	import starling.display.BlendMode;
	import br.com.ef5.ariane.crushTheLadyBug.Supplies;
	import starling.display.Image;
	import starling.events.Event;
	import feathers.controls.Button;
	import feathers.controls.Screen;

	[Event(name="showGameView",type="starling.events.Event")]
	/**
	 * @author Ariane Oliveira
	 */
	public class Home extends Screen {
		public static const SHOW_GAMEVIEW : String = "showGameView";
		private var playButton : Button;
		private var bg : Image;
		private var playButtonImage : Image;

		public function Home() {
			super();
		}

		override protected function initialize() : void {
		
			bg = new Image(Supplies.getTexture("startBg")) ;
			addChild(bg);
			
			playButton  = new Button();
			addChild(playButton);
			playButton.addEventListener(Event.TRIGGERED, playButtonHandler);
			
			playButtonImage = new Image(Supplies.getTexture("playButton"));
			playButton.defaultIcon = playButtonImage;
		}
		
		override protected function draw():void
		{
			bg.x = 0;
			bg.y = 0;
			
			bg.width =  this.actualWidth;
			bg.height =  this.actualHeight;
			
			this.playButton.width = this.actualWidth * 0.40;
			this.playButton.height = (this.actualHeight) * 0.10;
			this.playButton.x = (this.actualWidth - playButton.width)/2;
			this.playButton.y = (this.actualHeight * 0.70);
		}

		private function playButtonHandler($event:Event) : void {
			
			this.dispatchEventWith(SHOW_GAMEVIEW);
		}
	}
}
