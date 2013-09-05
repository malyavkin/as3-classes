package com.am_devcorp.ext.xbox {
	import com.am_devcorp.ext.xbox.JoystickEvent;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	
	public class XINPUT_STATE_Event extends JoystickEvent{
		public var A_PRESSED:Boolean            = false
		public var B_PRESSED:Boolean            = false
		public var X_PRESSED:Boolean            = false
		public var Y_PRESSED:Boolean            = false
		public var DPAD_UP_PRESSED:Boolean      = false
		public var DPAD_DOWN_PRESSED:Boolean    = false
		public var DPAD_LEFT_PRESSED:Boolean    = false
		public var DPAD_RIGHT_PRESSED:Boolean   = false
		public var LB_PRESSED:Boolean           = false
		public var RB_PRESSED:Boolean           = false
		public var BACK_PRESSED:Boolean         = false
		public var START_PRESSED:Boolean        = false
		public var LSTICK_PRESSED:Boolean       = false
		public var RSTICK_PRESSED:Boolean       = false
		
		public var LSTICK:Point
		public var RSTICK:Point
		public var LTRIGGER:uint
		public var RTRIGGER:uint
		
		
		public function XINPUT_STATE_Event(STATE:XML) {
			super(STATE_READ)
			var categories:XMLList = STATE.children()
			var sticks:XML = STATE.children()[0]
			var buttons:uint = STATE.children()[1];
			var triggers:XML = STATE.children()[2]
			//STICKS
			LSTICK = new Point( sticks.children()[0].children()[0]/32760,
								sticks.children()[0].children()[1]/32760)
			RSTICK = new Point( sticks.children()[1].children()[0]/32760,
								sticks.children()[1].children()[1]/32760)			
			//BUTTONS
			if(buttons & 0x0001) DPAD_UP_PRESSED 	 = true
			if(buttons & 0x0002) DPAD_DOWN_PRESSED	 = true
			if(buttons & 0x0004) DPAD_LEFT_PRESSED	 = true
			if(buttons & 0x0008) DPAD_RIGHT_PRESSED	 = true
			if(buttons & 0x0010) START_PRESSED		 = true
			if(buttons & 0x0020) BACK_PRESSED		 = true
			if(buttons & 0x0040) LSTICK_PRESSED		 = true
			if(buttons & 0x0080) RSTICK_PRESSED		 = true
			if(buttons & 0x0100) RB_PRESSED			 = true
			if(buttons & 0x0200) RB_PRESSED			 = true
			if(buttons & 0x1000) A_PRESSED			 = true
			if(buttons & 0x2000) B_PRESSED			 = true
			if(buttons & 0x4000) X_PRESSED			 = true
			if(buttons & 0x8000) Y_PRESSED			 = true
			//TRIGGERS
			LTRIGGER = triggers.children()[0]
			RTRIGGER = triggers.children()[1]
			
		}
		
	}

}