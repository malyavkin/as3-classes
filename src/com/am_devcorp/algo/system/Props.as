package com.am_devcorp.algo.system {
	import flash.net.ServerSocket;
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Props {
		
		public function Props() {
			
		}
		public static function get air():Boolean {
			var AIR:Boolean
			try {
				var ss:ServerSocket;
				ss = null;
				AIR = true;
			} catch (err:Error){
				AIR = false;
			}
			return AIR;
		}
	}

}