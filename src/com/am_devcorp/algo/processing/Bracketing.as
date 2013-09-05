package com.am_devcorp.algo.processing {
	//TODO: escape brackets
	import adobe.utils.CustomActions;
	/**
	 * 
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Bracketing {
		/** Содержит пары индексов левой и правой скобок*/ 
		public var brackets:Vector.<Array>
		private var length:uint
		public function Bracketing(s:String, backslashEscaping:Boolean, openChars:String = "({[", closeChars:String =")}]" ) {
			//проверяем равенство количества открывающих типов скобок закрывающим
			if (openChars.length != closeChars.length) {
				throw new Error("bad input");
			}
			//TODO: проверить уникальность типов скобок и совпадение колва открывающих и закрывающих в s
			/** Индекс элемента в массиве -- уровень вложенности, значение -- индекс в строке s */
			var lBrackets:Vector.<uint> = new Vector.<uint>
			/** Индекс элемента в массиве соответствует индексу в lBrackets, значение -- индекс в строке openChars */
			var bracketTypes:Vector.<uint> = new Vector.<uint>
			// всё ОК, можно начинать
			length = s.length
			brackets = new Vector.<Array>;
			
			for (var i:int = 0; i < length; i++) {
				var ch:String = s.charAt(i);
				if (ch == "\\" && backslashEscaping) {
					//omitting this and next char
					i++;
					continue;
				}
				//тип открывающей скобки (если есть; иначе -1)
				var lBracketType:int = openChars.indexOf(ch)
				//тип закрывающей скобки (если есть; иначе -1)
				var rBracketType:int = closeChars.indexOf(ch)
				if (lBracketType != -1) {
					//мы встретили открывающую скобку 
					lBrackets.push(i)
					bracketTypes.push(lBracketType)
				} else if (rBracketType !=-1) {
					//мы встретили закрывающую скобку
					var correspondingLBracketIndex:uint = lBrackets.pop()
					var correspondingLBracketType:uint = bracketTypes.pop()
					if (correspondingLBracketType == rBracketType) {
						//тип закрывающей скобки соответствует типу открывающей
						brackets.push([correspondingLBracketIndex,i])
					} else {
						//тип закрывающей скобки НЕ соответствует типу открывающей
						throw new Error("bad bracing near char "+i+"; expected: \'"+closeChars.charAt(correspondingLBracketType)+"\'; got: \'"+ch+"\'")
					}
				} 
			}
		}
		
		/**
		 * Entire function in a nutshell
		 * 
		 * index  | 0  1  2  3  4  5  6  7  8  9 10 
		 * string |"a  a  a  (  b  b  b  )  c  c  c "
		 * map    |-1 -1 -1  7 -1 -1 -1  3 -1 -1 -1 
		 * @return map
		 */
		public function get map():Vector.<int> {
			var vec:Vector.<int> = new Vector.<int>
			vec.length = length
			for (var j:int = 0; j < vec.length; j++) {
				vec[j] = -1
			}
			for each (var i:Array in brackets) {
				
				vec[i[0]] = i[1]
				vec[i[1]] = i[0]
			}
			
			return vec
			
		}
	}

}