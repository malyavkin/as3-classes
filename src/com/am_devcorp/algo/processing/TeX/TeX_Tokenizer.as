package com.am_devcorp.algo.processing.TeX {
    /**
     * Служит для разбора строки на TeX-like команды
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    import com.am_devcorp.algo.processing.Bracketing;
    
    internal class TeX_Tokenizer {
        
        public static const ESCAPE_TRIGGER:String = "\\"
        //TODO: these
        public static const ESCAPE_CHARS:String = "{}\\"
        
        public function TeX_Tokenizer() {
        
        }
        
        /**
         * Goes through the string, finds commands'n'arguments and recursively
         * parses them!
         * @param	s String to parse
         * @return Vector of tokens
         */
        public static function tokenize(s:String):Vector.<TeX_Token> {
            function flush_plaintext():void {
                if (plaintext_buffer != "") {
                    content.push(new TeX_PlaintextToken(plaintext_buffer))
                    plaintext_buffer = "";
                }
            }
            var content:Vector.<TeX_Token> = new Vector.<TeX_Token>
            var map:Vector.<int> = new Bracketing(s, true, "{", "}").map
            var plaintext_buffer:String = ""
            var ptr:uint = 0
            while (ptr < s.length) {
                var ch:String = s.charAt(ptr)
                if (ch == ESCAPE_TRIGGER) {
                    var command:String
                    var args:Vector.<String> = new Vector.<String>
                    //no more plaintext
                    flush_plaintext();
                    //getting the command name
                    var temp_ptr:uint = ptr + 1;
                    while (/[a-zA-Z]/.test(s.charAt(temp_ptr)) && temp_ptr < s.length) {
                        temp_ptr++;
                    }
                    command = s.substring(ptr + 1, temp_ptr);
                    // getting arguments (temp_ptr points to next char)
                    //FIXME: there may be spaces between command name and {
                    try {
						
						while (s.charAt(temp_ptr) == "{") {
							//there is an argument
							//getting corresponding bracket and substring-ing argument out!
							var rBracket:int = map[temp_ptr];
							if (rBracket == -1 || rBracket <= temp_ptr) {
								throw new Error("what the fk")
							}
							args.push(s.substring(temp_ptr + 1, rBracket));
							temp_ptr = rBracket + 1;
						}
					} catch (err:Error){
						
					}
                    /**
                     * So now we have name of the command stored in "command"
                     * with raw arguments stored in "args"
                     * Now we parse args, push them to content and update pointer
                     */
                    if (args.length) {
                        var parsed_args:Vector.<Vector.<TeX_Token>> = new Vector.<Vector.<TeX_Token>>;
                        for each (var arg:String in args) {
                            parsed_args.push(tokenize(arg));
                        }
                        content.push(new TeX_Token(command, parsed_args));
                    } else {
                        content.push(new TeX_Token(command));
                    }
                    
                    ptr = temp_ptr
                    
                } else {
                    plaintext_buffer += ch
                    ptr++
                }
            }
            flush_plaintext()
            return content
        
        }
    }

}