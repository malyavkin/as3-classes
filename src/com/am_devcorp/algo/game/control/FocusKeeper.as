package com.am_devcorp.algo.game.control {
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	
	/**
	 * Эта штука может закреплять фокус ввода клавиатуры на себе и передавать KeyboardEvent-ы Input-у
	 * После этого состояние клавиатуры можно будет прочитать из Input-а
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class FocusKeeper extends Sprite {
		private static var focustarg:Input
		
		public function FocusKeeper():void {
			addEventListener(Event.ADDED_TO_STAGE, ENGAGE)
		}
		
		private function ENGAGE(e:Event):void{
			this.stage.focus = this
			removeEventListener(Event.ADDED_TO_STAGE, ENGAGE)
			addEventListener(FocusEvent.FOCUS_OUT, FOCUS_OUT)
		}
		
		private function FOCUS_OUT(e:FocusEvent = null):void {
			this.stage.focus = this; //no, you ain't going anywhere! >:D
		}
		
		public function keep(obj:Input):void {
			if (focustarg){
				removeEventListener(KeyboardEvent.KEY_UP, focustarg.inputHandler)
				removeEventListener(KeyboardEvent.KEY_DOWN, focustarg.inputHandler)
			}
			if (obj){
				focustarg = obj
				addEventListener(KeyboardEvent.KEY_UP, focustarg.inputHandler)
				addEventListener(KeyboardEvent.KEY_DOWN, focustarg.inputHandler)
			}
		}
	
	}

}