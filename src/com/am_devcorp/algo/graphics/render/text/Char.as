package com.am_devcorp.algo.graphics.render.text {
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class Char {
        public var tiles:Array
        public var width:uint = 1;
		/**
		 * на сколько тайлов опустить символ при печати
		 * baseline = 0 baseline = 1 
		 * 
		 *   xx           
		 *   xx           xx
		 * __xx___________xx_______
		 *                xx
		 * 
		 */
        public var baseline:int = 0;
        public var code:String
        
        public function get height():uint {
            return Math.ceil(tiles.length / width) as uint
        }
    
    }

}