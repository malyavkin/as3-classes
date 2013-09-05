package com.am_devcorp.algo.graphics {
    import flash.geom.Point;
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class IntPoint {
        
        public var x:int
        public var y:int
        
        public function get as_point():Point {
            return new Point(x, y)
        }
        public function get as_array():Array {
            return [x, y]
        }
        public function get copy():IntPoint{
            return new IntPoint(x,y)
        }
        public function IntPoint(x:int = 0, y:int = 0) {
            this.x = x
            this.y = y
        }
		public function toString():String {
			return "[x="+x.toString()+";y="+y.toString()+"]"
		}
    }

}