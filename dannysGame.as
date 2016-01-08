package
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class dannysGame extends MovieClip
	{
		var vx:int;
		var vy:int;
		var rightInnerBoundry:uint;
		var leftInnerBoundry:uint;
		var topInnerBoundry:uint;
		var bottomInnerBoundry:uint;
		var score:uint;
		var collisionHasOccurred:Boolean;
		var playerHasApple:Boolean;
		var appleStarX:uint;
		var appleStartY:uint;
		
		public function dannysGame()
		{
			init();
		}
		function init():void
		{
			
		 //init vars
		 vx = 0;
		 vy = 0;
		 score = 0;
		 collisionHasOccurred = false;
		 playerHasApple = false;
		 //appleStartX = foo.apple.x;
		 appleStartY = foo.apple.y;
		 
		 //init enemy
		 enemy.stop();
		 
		 rightInnerBoundry = (stage.stageWidth / 2)
		 	+ (stage.stageWidth / 4);
		 leftInnerBoundry = (stage.stageWidth / 2)
		 	- (stage.stageWidth / 4);
		topInnerBoundry = (stage.stageHeight / 2)
		 	- (stage.stageHeight / 4);
			bottomInnerBoundry = (stage.stageHeight / 2)
		 	+ (stage.stageHeight / 4);
			
		 //add event listener
		 stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		 stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		 addEventListener(Event.ENTER_FRAME, onEnterFrame);
	    }
		 function onKeyDown(event:KeyboardEvent):void
		 {
			 if (event.keyCode == Keyboard.LEFT)
			 {
				 vx = -5;
			 }
		  	else if (event.keyCode == Keyboard.RIGHT)
			{
				vx = 5;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				vy = -5;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				vy = 5;
			}
			if (event.keyCode == Keyboard.SPACE && player.hitTestObject(foo.apple))
			{
				 if (! playerHasApple)
				{
					player.addChild(foo.apple);
					foo.apple.x = 0;
					foo.apple.y = 0;
					playerHasApple = true;
				}
				else if(enemy.hitTestObject(foo.apple))
				{ 
						enemy.addChild(foo.apple);
						foo.apple.x = 0;
						foo.apple.y = 0;
						if(playerHasApple){
						messageDisplay.fee.text = "Thanks!";
						}
						playerHasApple = false;
				}
				else
				{
					foo.addChild(foo.apple);
					//foo.apple.x = appleStartX;
					foo.apple.y = appleStartY;
					playerHasApple = false; 
					
				}
			}
		 }
		 function onKeyUp(event:KeyboardEvent):void
		 {
			 if (event.keyCode == Keyboard.LEFT ||
				 event.keyCode == Keyboard.RIGHT)
			 {
				 vx = 0;
			 }
			 else if (event.keyCode == Keyboard.DOWN ||
				 event.keyCode == Keyboard.UP)
			 {
				 vy = 0;
			 }
		 }
		 function onEnterFrame(event:Event):void
		 {
			 //move the player
			 
			 var playerHalfWidth:uint = player.width / 2;
			 var playerHalfHeight:uint = player.height / 2;
			 var backgroundHalfWidth:uint = foo.width / 2;
			 var backgroundHalfHeight:uint = foo.height / 2;
			 
			 //hardwired bad code
			 enemy.x = foo.x + 100;
			 enemy.y = foo.y;
			 
			/* if(! playerHasApple)
			 {
			 apple.x = foo.x + 50;
			 apple.y = foo.y + 100;
			 } */
			 
					  
					  
					  
			 //move player
			 player.x += vx;
			 player.y += vy;
			 
			
			 //colission detection
			 if (player.hitTestObject(enemy))
			 {
				 
				 enemy.gotoAndStop(2);
				 health.meter.width-= 2;
				 if(! collisionHasOccurred)
				 {
					 score++;
					 messageDisplay.fee.text = String(score);
					 collisionHasOccurred = true;
				 }
			 }
			 else 
			 {
				 enemy.gotoAndStop(1);
				 collisionHasOccurred = false;
			 }
			 
			 //check for end of game
		
			 
			 if(health.meter.width < 2)
			 {
				 messageDisplay.fee.text = "Game Over!!";
			 }
			 else if (score >= 7)
			 {
				 messageDisplay.fee.text = "You Won!!!";
			 }
			  
			  //prevent player from movining thru wall
			  //Collision.block(player,wall);
			 if (player.hitTestObject(foo.wall))
			 {
				 player.x -= vx;
				 player.y -= vy;
			 }
		
			 
			 //stop player at inner boundry edge
			 if(player.x - playerHalfWidth < leftInnerBoundry)
			 {
				 player.x = leftInnerBoundry + playerHalfWidth;
				 rightInnerBoundry = (stage.stageWidth / 2)
				 + (stage.stageWidth / 4);
				 foo.x -= vx;
			 }
			 else if(player.x + playerHalfWidth > rightInnerBoundry)
			 {
				 player.x = rightInnerBoundry - playerHalfWidth;
				 leftInnerBoundry = (stage.stageWidth / 2)
				 - (stage.stageWidth / 4);
				 foo.x -= vx;
			 }
			if (player.y - playerHalfHeight < topInnerBoundry)
			 {
				 player.y = topInnerBoundry + playerHalfHeight;
				 bottomInnerBoundry = (stage.stageHeight / 2)
				 + (stage.stageHeight / 4);
				 foo.y -= vy;
			 }
			 else if (player.y + playerHalfHeight > bottomInnerBoundry)
			 {
				 player.y = bottomInnerBoundry - playerHalfHeight;
				 topInnerBoundry = (stage.stageHeight / 2)
				 - (stage.stageHeight / 4);
				 foo.y -= vy;
			 }
			 
			 //stop player at stage edge
			 if (foo.x + backgroundHalfWidth < stage.stageWidth)
			 {
				 foo.x = stage.stageWidth - backgroundHalfWidth;
				 rightInnerBoundry = stage.stageWidth;
			 }
			 else if (foo.x - backgroundHalfWidth >  0)
			 {
				 foo.x = 0 + backgroundHalfWidth;
				 leftInnerBoundry = 0;
			 }
			 if (foo.y - backgroundHalfHeight > 0 )
			 {
				 foo.y = 0 + backgroundHalfHeight;
				 topInnerBoundry = 0;
			 }
			 else if (foo.y + backgroundHalfHeight < stage.stageHeight)
			 {
				 foo.y = stage.stageHeight - backgroundHalfHeight;
				 bottomInnerBoundry = stage.stageHeight;
			 }
			 
		 }
    } 
}