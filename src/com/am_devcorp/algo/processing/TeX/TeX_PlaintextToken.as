package com.am_devcorp.algo.processing.TeX {
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class TeX_PlaintextToken extends TeX_Token {
		private var _str:String;
		public function TeX_PlaintextToken(str:String) {
			super(TeX_TokenType.PLAIN);
			_str = str;
			
		}
		override public function toString():String {
			return _type+" \""+str+"\";"
		}
		
		public function get str():String {
			return _str;
		}
		
	}

}