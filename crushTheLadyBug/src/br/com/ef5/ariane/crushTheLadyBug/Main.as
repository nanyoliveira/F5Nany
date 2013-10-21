package br.com.ef5.ariane.crushTheLadyBug {
	import br.com.ef5.ariane.crushTheLadyBug.theme.MinimalMobileTheme;
	import br.com.ef5.ariane.crushTheLadyBug.view.GameView;
	import br.com.ef5.ariane.crushTheLadyBug.view.Home;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author Ariane Oliveira
	 */
	public class Main extends Sprite {
		private static const HORIZONTAL : String = "horizontal";
		private static const HOME : String = "Home";
		private static const GAME_VIEW : String = "GameView";
		private var theme : MinimalMobileTheme;
		private var navigator : ScreenNavigator;
		private var transitionManager : ScreenSlidingStackTransitionManager;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private function addedToStageHandler($event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			init();
		}

		private function init() : void {
			// set main theme
			theme = new MinimalMobileTheme(this.stage);

			// set screens
			navigator = new ScreenNavigator();
			addChild(navigator);

			navigator.addScreen(HOME, new ScreenNavigatorItem(Home, {showGameView:GAME_VIEW}));
			navigator.addScreen(GAME_VIEW, new ScreenNavigatorItem(GameView, {complete:HOME, ShowHome:HOME}));

			navigator.showScreen(HOME);

			transitionManager = new ScreenSlidingStackTransitionManager(navigator);
			transitionManager.duration = 0.4;
		}
	}
}
