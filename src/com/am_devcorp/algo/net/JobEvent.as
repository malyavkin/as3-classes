package com.am_devcorp.algo.net {
	import flash.events.Event;
	
	/**
	 * Carries download jobs through event flow
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class JobEvent extends Event {
		public var job:Job
		public function JobEvent(handler:String, job:Job) { 
			super(handler);
			this.job = job
		} 		
	}
	
}