package
{
	import events.NavigationEvent;
	import screens.InGame;
	import screens.Welcome;
	import starling.events.Event;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SHENGbanX
	 */
	public class Game extends Sprite
	{
		private var screenWelcome:Welcome;
		private var screenInGame:InGame;
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			trace("starling framework initialized");
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			
			
			screenInGame = new InGame();
			screenInGame.addEventListener(NavigationEvent.CHANGE_SCREEN, onInGameNavigation);
			this.addChild(screenInGame);
			
			screenWelcome.initialize();
			screenInGame.disposeTemporarily();
		
		}
		
		private function onChangeScreen(e:NavigationEvent):void
		{
			switch (e.params.id)
			{
				case "play": 
					screenWelcome.disposeTemporarily();
					screenInGame.initialize();
					break;
			}
		}
		
		private function onInGameNavigation(e:NavigationEvent):void
		{
			switch (e.params.id)
			{
				case "mainMenu":
					screenWelcome.showWelcomeScreen();
					screenInGame.disposeTemporarily();
					break;
					
				case "about":
					screenWelcome.initialize();
					screenWelcome.showAbout();
					break;
			}
		}
	
	}

}