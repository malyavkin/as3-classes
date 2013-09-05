package com.am_devcorp.algo.graphics.render.text {
    import flash.display.BitmapData;
    //import flash.display.BitmapDataChannel;
    import flash.geom.Point;
    //import flash.utils.ByteArray;
    //import flash.xml.XMLNode;
    import flash.geom.Rectangle
    
    //TODO:write docs
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class TiledFont {
        private var tileHeight:uint
        private var tileWidth:uint
        private var tiles_per_string:uint
        private var charset:Vector.<Char>
        
        private var font_ptr:BitmapData
        private var map_res:XML
        
        public function TiledFont(fontPtr:BitmapData, mappingPtr:XML) {
            charset = new Vector.<Char>
            font_ptr = fontPtr;
            map_res = mappingPtr;
            
            initCharset(map_res)
        }
        
		private function initCharset(map:XML):void {
            tileWidth = map.attribute("width")
            tileHeight = map.attribute("height")
            
            tiles_per_string = font_ptr.width / tileWidth
            
            //parsing chars
            var processing_chr:Char
            var mapping_chr:Char
            for each (var chr:XML in map.char) {
                processing_chr = new Char()
                processing_chr.baseline = chr.attribute("baseline")
                processing_chr.tiles = (new String(chr.attribute("tiles"))).split(",")
                
                processing_chr.width = chr.attribute("width")
                processing_chr.code = chr.attribute("code")
                addToCharset(processing_chr)
            }
            for each (var mapping:XML in map.map) {
                mapping_chr = new Char()
                var mapTo:int = getCharacterIDByCode(mapping.attribute("to"))
                if (mapTo == -1) {
                    trace("2:/!\\ character \"" + mapping.attribute("latex") + "\" is incorrectly mapped. omitting")
                } else {
                    
                    mapping_chr.baseline = charset[mapTo].baseline
                    mapping_chr.tiles = charset[mapTo].tiles
                    mapping_chr.width = charset[mapTo].width
                    mapping_chr.code = mapping.attribute("code")
                    addToCharset (mapping_chr)
                }
                
            }
        }
		
		private function addToCharset(char:Char):void {
            if (getCharacterIDByCode(char.code) == -1) {
                charset.push(char)
            } else {
                trace("2:/!\\ character duplicate detected(" + char.code + "). omitting")
            }
        }
		
		private function getCharacterByCode(code:String):Char {
            var i:int = getCharacterIDByCode(code)
            if (i != -1) {
                return charset[i]
            }
            return null
        }
		
		private function getCharacterIDByCode(code:String):int {
            for (var i:int = 0; i < charset.length; i++) {
                if (charset[i].code == code) {
                    return i
                }
            }
            return -1
        }
		
        public function get tileFormat():Point {
            return new Point(tileWidth, tileHeight)
        }
        
        public function getPixelsForText(s:String):BitmapData {
            //plan:
            //1: separate text to strings at \newline<space> and \n
            //in: s:String out: strings:Vector.<String>
            var strings:Vector.<String> = new Vector.<String>
            var i:uint = 0;
            while (i < s.length) { //s => vector 
                var bs_n:uint = s.indexOf("\n", i);
                var bs_newline:uint = s.indexOf("\\newline ", i);
                var cut_pos:int
                var additionalCut:int
                if (bs_n > bs_newline) {
                    cut_pos = bs_newline
                    additionalCut = "\\newline ".length
                } else {
                    cut_pos = bs_n
                    additionalCut = "\n".length
                }
                if (cut_pos == -1) {
                    cut_pos = s.length
                    additionalCut = 0;
                }
                strings.push(s.substring(i, cut_pos))
                i = cut_pos + additionalCut
            }
            //2: get bunch of bitmaps from these strings
            //in: strings:Vector.<String> out: bitmaps:Vector.<BitmapData>
            var totalWidth:uint
            var totalHeight:uint
            var bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>
            for (var j:int = 0; j < strings.length; j++) {
                var str:BitmapData = getPixelsForString(strings[j])
                bitmaps.push(str)
                totalHeight += str.height
                if (str.width > totalWidth) {
                    totalWidth = str.width
                }
            }
            //3: stick them together
            //in: bitmaps:Vector.<BitmapData> out: total_bitmap:BitmapData
            var total_bitmap:BitmapData = new BitmapData(totalWidth, totalHeight, true, 0)
            var vcaret:uint
            for (var k:int = 0; k < bitmaps.length; k++) {
                var selected_bmap:BitmapData = bitmaps[k];
                total_bitmap.copyPixels(selected_bmap, selected_bmap.rect, new Point(0, vcaret), null, null, true)
                vcaret += selected_bmap.height
            }
            //4: return this shit	
            return total_bitmap
        }
        
        private function getPixelsForString(s:String):BitmapData {
            const BACKSLASH:String = "\\"
			//plan
            //1. separate string into characters
			var not_letter:RegExp = /[^A-Za-z]/g
			
            var fineString:Vector.<Char> = new Vector.<Char>
            while (caret < s.length) { // s >> fineString
                var character:String
                var characterIndex:int
                if (s.charAt(caret) == BACKSLASH) {
					caret++
					not_letter.lastIndex = caret
					not_letter.exec(s)
                    var nearestSpace:int = not_letter.lastIndex
                    nearestSpace = (nearestSpace == 0 ? s.length : nearestSpace)
                    character = s.substring(caret, nearestSpace)
                    caret += character.length
                } else {
                    character = s.charAt(caret)
                    caret++
                }
                characterIndex = getCharacterIDByCode(character)
                if (characterIndex != -1) {
                    fineString.push(getCharacterByCode(character))
                } else {
                    fineString.push(getCharacterByCode("err"))
                }
            }
            var linesAboveMain:int
            var linesBelowMain:int
            var width:uint
            for each (var ch:Char in fineString) {
                width += ch.width
                var ch_linesAboveMain:int = ch.height - 1 - ch.baseline
                var ch_linesBelowMain:int = ch.baseline
                
                if (ch_linesAboveMain > linesAboveMain) {
                    linesAboveMain = ch_linesAboveMain;
                }
                if (ch_linesBelowMain > linesBelowMain) {
                    linesBelowMain = ch_linesBelowMain;
                }
                
            }
            //2. generate bitmap from these characters
            var caret:uint = 0;
            
            var bitmapString:BitmapData = new BitmapData(width * tileWidth, (linesAboveMain + linesBelowMain + 1) * tileHeight, true, 0)
            var bitmap_caret:uint
            for (var i:int = 0; i < fineString.length; i++) {
                var c:Char = fineString[i]
                var characterBitmap:BitmapData = getPixelsForChar(c)
                bitmapString.copyPixels(characterBitmap, characterBitmap.rect, new Point(bitmap_caret * tileWidth, (linesAboveMain + 1 + c.baseline- c.height) * tileHeight), null, null, true)
                bitmap_caret += c.width
            }
            
            //3. return this shit
            return bitmapString
        
        }
        public function getPixelsForCode(code:String):BitmapData {
			return getPixelsForChar(getCharacterByCode(code));
		}
        private function getPixelsForChar(c:Char):BitmapData {
            var sample_bitmap:BitmapData = new BitmapData(c.width * tileWidth, c.height * tileHeight, true, 0);
            var dst_pos:uint = 0;
            var dst_line:uint = 0;
            for (var i:int = 0; i < c.tiles.length; i++) {
                var src_pos:uint = c.tiles[i] % tiles_per_string;
                var src_line:uint = c.tiles[i] / tiles_per_string;
				sample_bitmap.copyPixels(font_ptr,new Rectangle(src_pos * tileWidth, src_line * tileHeight, tileWidth, tileHeight),new Point(dst_pos * tileWidth, dst_line * tileHeight),null,null,true)
                dst_pos++;
                if (dst_pos == c.width) {
                    dst_pos = 0;
                    dst_line++;
                }
            }
            return sample_bitmap;
        }
    }

}