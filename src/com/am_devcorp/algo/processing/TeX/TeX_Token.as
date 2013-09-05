package com.am_devcorp.algo.processing.TeX {
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class TeX_Token {
		
		internal var _type:String
		internal var _args:Vector.<Vector.<TeX_Token>>
		//private var up:Vector.<TeX_Token>
		//private var down:Vector.<TeX_Token>
		public function TeX_Token(type:String, args:Vector.<Vector.<TeX_Token>>  = null) {
			//очень хитрая и игра: если args существует -- мы его дублируем
			_args = args?args.slice():null
			_type = type
		}
		public function get type():String {
			return _type
		}
		public function get args():Vector.<Vector.<TeX_Token>> {
			return _args.slice()
		}
		public function toString():String {
			var s:String = "token " + _type ;
			
			for each (var i:Vector.<TeX_Token> in _args) {
				var ss:String = "{\n"
				for each (var j:TeX_Token in i) {
					var strings:Array = j.toString().split("\n")
					for each (var k:String in strings) {
						
						ss+="    "+k+"\n"
					}
				}
				s+=(ss+"}")
				
			}
			s+=";"
			return s
		}
	}

}