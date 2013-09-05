package com.am_devcorp.algo.tools {
	import com.am_devcorp.algo.system.LightError;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Assert {
		public static const TRACE_ERRORS:String = "trace"
		public static const THROW_ERRORS:String = "throw"
		public static var MODE:String = "throw"
		
		public static var errName:String = "AssertionError"
		public function Assert(v:*) {
			if (!(v as Boolean)) {
				if (MODE == THROW_ERRORS) {
					throw new  LightError(errName)
				}
				else {
					try {
						throw new LightError(errName)
					}catch (err:Error) {
						trace(err.getStackTrace())
					}
					
				}
				
			}
			
		}
		
	}

}