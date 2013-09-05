package com.am_devcorp.algo.graphics.render.rasterstage {
	import flash.display.BitmapData;
	import flash.geom.Point
	import com.am_devcorp.algo.graphics.IntPoint;
	import flash.geom.Rectangle;
	
	//TODO other cool transformations such as scale
	//TODO URGENT: merge with rasterContainer, all above and 1) merging w/another images 

	/**
	 * 
	 * @author Malyavkin Alexey
	 */
	
	
	public class RasterSprite {
		private var self:BitmapData
		// Позиция спрайта относительно родителя
		private var _position:IntPoint
		// Флаг горизонтального отражения
		private var _mirrorX_flag:Boolean = false
		// Флаг вертикального отражения
		private var _mirrorY_flag:Boolean = false
		// дочерние спрайты
		//public var content:Vector.<RasterSprite>
		
		
		public function RasterSprite(width:int, height:int){
			self = new BitmapData(width, height, true, 0);
			_position = new IntPoint();
			//content = new Vector.<RasterSprite>;
		}
		public function setSize(width:uint,height:uint, fill:uint = 0):void {
			var after:BitmapData = new BitmapData(width,height, true, fill);
			after.copyPixels(self, self.rect, new Point(), null, null, true)
			self = after;
		}
		
		public function resize(up:int, right:int, down:int,left:int, fill:uint = 0):void {
			var after:BitmapData = new BitmapData(width + left + right, height + up + down, true, fill);
			after.copyPixels(self, self.rect, new Point(up, left), null, null, true)
			self = after;
		}
		public function tile(v:BitmapData):void {
			var hcaret:uint = 0 // horizontal
			var vcaret:uint = 0 // vertical
			while (vcaret<height) {
				hcaret = 0
				while (hcaret<width) {
					paste(v, new IntPoint(hcaret, vcaret))
					hcaret+=v.width
				}
				vcaret+=v.height
			}
		}
		public function paste(v:BitmapData, at:IntPoint):void {
			self.copyPixels(v, v.rect, at.as_point, null, null, true);
		}
		
		/**
		 * отзеркаливает картинку слева направо
		 */
		public function _mirrorX():void {
			var copy:BitmapData = self.clone()
			self.fillRect(self.rect, 0)
			self.lock()
			for (var i:int = 0; i < self.width; i++){
				self.copyPixels(copy, new Rectangle(i, 0, 1, self.height), new Point(self.width - i - 1, 0), null, null, true)
			}			
			self.unlock()
			_mirrorX_flag = !_mirrorX_flag
		}
		/**
		 * отзеркаливает картинку сверху вниз
		 */
		public function _mirrorY():void {
			
			var copy:BitmapData = self.clone()
			self.fillRect(self.rect, 0)
			self.lock()
			for (var i:int = 0; i < self.height; i++){
				self.copyPixels(copy, new Rectangle(0, i, self.width, 1), new Point(0, self.height - i - 1), null, null, true)
			}
			self.unlock()
			_mirrorY_flag = !_mirrorY_flag
		}
		public function reset():void {
            mirrorX = false;
            mirrorY = false;

		}
		// NUDGE IS DISABLED
		/* 
		//RELATIVE values
		public function move(x:int, y:int):void {
			nudge(_nudge.x + x,_nudge.y + y)
			
		}
		//абсолютные значения
		public function nudge(nx:int,ny:int):void {
			nx %= self.width
			ny %= self.height
			nx-=_nudge.x
			ny-=_nudge.y
			_nudge.x+=nx
			_nudge.y+=ny
			
			if (_mirrorX_flag) {
				nx = -nx
			}
			if (_mirrorY_flag) {
				ny = -ny
			}
			
			
			//далее: v -- относительное смещение
			var copy:BitmapData = self.clone()
			
			var absx:uint = Math.abs(nx)
			var absy:uint = Math.abs(ny)
			var left_wi:uint = nx < 0 ? absx : copy.width - absx
			var right_wi:uint = nx < 0 ? copy.width - absx : absx
			var top_he:uint = ny < 0 ? absy : copy.height - absy
			var bottom_he:uint = ny < 0 ? copy.height - absy : absy
			
			self.lock()
			//TODO: not sure if needed: need to read livedocs
			//self.fillRect(self.rect, 0)
			self.copyPixels(copy, new Rectangle(0, 0, left_wi, top_he), new Point(right_wi, bottom_he), null, null, true)
			self.copyPixels(copy, new Rectangle(left_wi, 0, right_wi, top_he), new Point(0, bottom_he), null, null, true)
			self.copyPixels(copy, new Rectangle(0, top_he, left_wi, bottom_he), new Point(right_wi, 0), null, null, true)
			self.copyPixels(copy, new Rectangle(left_wi, top_he, right_wi, bottom_he), new Point(0, 0), null, null, true)
			self.unlock()
		}*/
		/**
		 * Loads picture
		 * @param	v BitmapData to load
		 */
		public function loadPicture(v:BitmapData):void {
			self = v.clone()
		}
		/**
		 * 
		 * @return
		 */
		public function getPicture():BitmapData {
			return self.clone()
		}
		
		
		/**
		 * 
		 */
		public function get mirrorX():Boolean {
			return _mirrorX_flag
		}
		/**
		 * 
		 */
		public function set mirrorX(v:Boolean):void{
			
			if (_mirrorX_flag != v) {
				_mirrorX()
			}
		}
		/**
		 * 
		 */
		public function get mirrorY():Boolean {
			return _mirrorY_flag
		}
		/**
		 * 
		 */
		public function set mirrorY(v:Boolean):void{
			if (_mirrorY_flag != v) {
				_mirrorY()
			}
		}
		/**
		 * 
		 */
		public function get width():uint {
			return self.width
		}
		/**
		 * 
		 */
		public function get height():uint {
			return self.height
		}
		/**
		 * 
		 */
		public function get x():int {
			return _position.x
		}
		/**
		 * 
		 */
		public function set x(v:int):void {
			_position.x = v
		}
		/**
		 * 
		 */
		public function get y():int {
			return _position.y
		}
		/**
		 * 
		 */
		public function set y(v:int):void {
			_position.y = v
		}
		public function get pos():Point{
			return _position.as_point
		}
		//TODO: override nextframe, prevframe,goto, etc. WAT oO
		
	}

}