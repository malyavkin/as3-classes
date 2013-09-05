package com.am_devcorp.algo.system {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class SmartTimer extends Timer{ 
		private var timers:Vector.<uint>
		private var currentTimer:uint
		public function SmartTimer(...delays) {
			super(0, 1);
			timers = new Vector.<uint>;
			if (!delays.length) {
				throw new ArgumentError("No input specified")
			}
			for (var i:int = 0; i < delays.length; i++) {
				if (delays[i] > 0) {
					timers.push(uint(delays[i]));
				}
				else throw new ArgumentError("Negative delay in input")
			}
			delay = timers[0];
			addEventListener(TimerEvent.TIMER, onTimer);
		}
		private function onTimer(e:TimerEvent):void {
			if (++currentTimer >= timers.length) {
				currentTimer = 0;
			}
			delay = timers[currentTimer];
			repeatCount = 1;
			super.reset();
			super.start();
		}
		public function rewind():void {
			super.reset();
			currentTimer = 0;
			super.start();
		}
		public function get numTimers():uint {
			return timers.length
		}
		
	}

}