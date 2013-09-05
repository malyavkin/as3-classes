package com.am_devcorp.algo.system {
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class LightError extends Error{
		
		public function LightError(msg:String="", id:int=0) {
			super(msg, id)
		}
		override public function getStackTrace():String {
			var stack:String = super.getStackTrace()
			stack = stack.substring(stack.indexOf("\n") + 1, stack.length)
			stack = stack.substring(stack.indexOf("\n") + 1, stack.length)
			stack = stack.substring(0,stack.indexOf("\n\tat runtime::ContentPlayer/loadInitialContent()"))
			stack = "Error: " + this.message + "\n" + stack
			return stack
		}
		
	}

}