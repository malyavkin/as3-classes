package com.am_devcorp.algo.graphics.render.rasterstage {
	import flash.display.Bitmap
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class RasterScreen extends Bitmap {
		public var rootSprite:RasterSprite;
		
		public function RasterScreen(root:RasterSprite) {
			super()
			rootSprite = root;
			
		}
		public function upd():void {
			this.bitmapData = rootSprite.getPicture()
		}
		
	}

}