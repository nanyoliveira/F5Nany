package br.com.ef5.ariane.crushTheLadyBug {
	import flash.display.LoaderInfo;
	import flash.events.UncaughtErrorEvent;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;

	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import br.com.ef5.ariane.crushTheLadyBug.view.GameView;
	import br.com.ef5.ariane.crushTheLadyBug.view.Home;

	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScreenNavigator;

	import br.com.ef5.ariane.crushTheLadyBug.theme.MinimalMobileTheme;

	import starling.events.Event;
	import starling.display.Sprite;

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
			initFlox();

			init();
		}

		private function initFlox() : void {
			Flox.init("nCwmwWqxlL2Rfx1Z", "Glk5gzAe0fymSZyI", "0.9");
			var currentPlayer : Player = Player.current;
			Flox.logEvent("currentPlayer" + currentPlayer);
			Player.loginWithEmail("ariane.oliveira.spyke@gmail.com", onLoggedIn, onLoggedInError);

		}

		private function onLoggedInError() : void {
			Flox.logError("error on Log in");
		}

		private function onLoggedIn() : void {
			Flox.logInfo("Log in");
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
