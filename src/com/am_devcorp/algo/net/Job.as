package com.am_devcorp.algo.net {
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Job {
		
		public var url:String
		public var data:ByteArray
		public function Job(url:String,data:ByteArray) {
			this.url = url
			this.data = data
		}
		
	}

}