package com.am_devcorp.algo.processing.TeX {
	/**
	 * Provides access to top-level functions such as Parse()
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class TeX {
		/**
		 * Decodes TeX-formatted string into TeX_Token structure
		 * @param	s TeX-formatted string
		 * @return  TeX_Token structure 
		 */
		public function Parse(s:String):TeX_Token {
			return new TeX_Parser(s).getRoot();
		}
		
	}

}