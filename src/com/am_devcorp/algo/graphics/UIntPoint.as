package com.am_devcorp.algo.graphics {
	import flash.geom.Point
	/**
	 * ...
	 * @author Malyavkin Alexey <a@malyavk.in>
	 */
    public class UIntPoint {
        
        private var _x:uint
        private var _y:uint
        
        public function get as_point():Point {
            return new Point(_x, _y)
        }
        public function get as_array():Array {
            return [_x, _y]
        }
        public function get copy():UIntPoint{
            return new UIntPoint(_x,_y)
        }
		
		public function get x():uint {
			return _x;
		}
		
		public function set x(value:uint):void {
			_x = value;
		}
		
		public function get y():uint {
			return _y;
		}
		
		public function set y(value:uint):void {
			_y = value;
		}
        public function UIntPoint(x:uint = 0, y:uint = 0) {
            this._x = x
            this._y = y
        }
		public function toString():String {
			return "[x="+_x.toString()+";y="+_y.toString()+"] u"
		}
    }

}