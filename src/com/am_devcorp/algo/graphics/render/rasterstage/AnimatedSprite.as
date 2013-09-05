package com.am_devcorp.algo.graphics.render.rasterstage {
	import com.am_devcorp.algo.system.SmartTimer;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class AnimatedSprite extends MultiframeSprite{
		private var timer:SmartTimer
		public function AnimatedSprite(width:uint, height:uint, frames:Vector.<BitmapData>, timer:SmartTimer) {
			super(width, height, frames)
			this.timer = timer
			if (numFrames % timer.numTimers)
			{
				throw new ArgumentError("Number of frames does not equal to number of timers")
			}
			this.timer.addEventListener(TimerEvent.TIMER,onTimer)
		}
		private function onTimer(e:TimerEvent):void {
			nextFrame()
		}
		public function sync():void {
			currentFrame = 0
			timer.rewind()
		}
		
		
	}

}