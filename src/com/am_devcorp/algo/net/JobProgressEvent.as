package com.am_devcorp.algo.net {
	import flash.events.Event;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class JobProgressEvent extends Event {
		public var url:String;
		public var status:String;
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		
		public function JobProgressEvent(handler:String,status:String,url:String,bytesLoaded:uint=0,bytesTotal:uint=0) {
			super(handler)
			this.url = url;
			this.status = status;
			this.bytesLoaded = bytesLoaded;
			this.bytesTotal = bytesTotal;
			
		}
		
	}

}