package com.am_devcorp.algo.graphics {
    import flash.geom.Point;
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class IntPoint {
        
        private var _x:int
        private var _y:int
        
        public function get as_point():Point {
            return new Point(_x, _y)
        }
        public function get as_array():Array {
            return [_x, _y]
        }
        public function get copy():IntPoint{
            return new IntPoint(_x,_y)
        }
		
		public function get x():int {
			return _x;
		}
		
		public function set x(value:int):void {
			_x = value;
		}
		
		public function get y():int {
			return _y;
		}
		
		public function set y(value:int):void {
			_y = value;
		}
        public function IntPoint(x:int = 0, y:int = 0) {
            this._x = x
            this._y = y
        }
		public function toString():String {
			return "[x="+_x.toString()+";y="+_y.toString()+"]"
		}
    }

}