package com.am_devcorp.algo.graphics.render.rasterstage {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class RasterContainer extends RasterSprite{
		public var content:Vector.<RasterSprite>
		
		public function RasterContainer(width:int, height:int) {
			super(width,height)
			content = new Vector.<RasterSprite>;
		}
		
		override public function getPicture():BitmapData {
			var result:BitmapData = super.getPicture();
			for (var i:int = 0; i < content.length; i++){
				var child:BitmapData = content[i].getPicture();
				result.copyPixels(child, child.rect, content[i].pos, null, null, true);
			}
			return result
		}
		//TODO: override transformations(mirriring) to propagate to children
		
	}

}