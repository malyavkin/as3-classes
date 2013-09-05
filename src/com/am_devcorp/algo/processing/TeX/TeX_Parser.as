package com.am_devcorp.algo.processing.TeX {
	import com.am_devcorp.algo.processing.Bracketing;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	internal class TeX_Parser {
		

		private var root:TeX_Token;

		public function TeX_Parser(s:String) {
			root = new TeX_Token("root");
			root._args = new Vector.<Vector.<TeX_Token>>			
			root._args.push(TeX_Tokenizer.tokenize(s));
		}
		public function getRoot():TeX_Token {
			return root;
		}
	}

}