package com.am_devcorp.ext.xbox {
	import flash.events.Event;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class JoystickEvent extends Event{
		public static const STATE_READ:String ="STATE_READ" 
		public static const BTN_PRESSED:String ="STATE_READ" 
		public static const BTN_RELEASED:String ="STATE_READ" 
		
		
		public function JoystickEvent(id:String){
			super(id)
		}
		
	}

}