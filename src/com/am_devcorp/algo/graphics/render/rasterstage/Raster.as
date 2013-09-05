package com.am_devcorp.algo.graphics.render.rasterstage {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Raster{
		// Позиция спрайта относительно родителя
		private var _position:IntPoint
		private var _self:BitmapData
		public function Raster(width:uint, height:uint, transparent:Boolean=true, fillColor:uint=0) {
			_self = new BitmapData(width, height, transparent, fillColor);
			
		
		}
		
	}

}