package com.am_devcorp.algo.graphics {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Comparator extends Sprite{
		
		private var b1:Bitmap
		private var b2:Bitmap
		public function Comparator(b1:Bitmap, b2:Bitmap) {
			this.b1 = b1
			this.b2 = b2
			
			
			var WIDTH:uint =b2.width
			var HEIGHT:uint = b2.height
			
			
			var b2_mask:Sprite = new Sprite()
			
			var wrapper:Sprite = new Sprite()
			
			wrapper.addChild(b1)
			wrapper.addChild(b2)
			wrapper.addChild(b2_mask)	
			
			b2_mask.graphics.beginFill(0xffffff)
			b2_mask.graphics.drawRect( -WIDTH, 0, WIDTH, HEIGHT)
			b2_mask.graphics.endFill()
			b2.mask = b2_mask
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
			
			
			
			function onMouseMove(e:MouseEvent):void {
				b2_mask.x = (e.stageX- wrapper.x)
				trace("aaaa")
			}
			addChild(wrapper)
		}
		override public function get width():Number {
			return Math.max(b1.width,b2.width)*scaleX;
		}
		
		override public function set width(value:Number):void {
			throw new Error("Property width is read-only")
		}
		
		override public function get height():Number {
			return Math.max(b1.height,b2.height)*scaleY
		}
		
		override public function set height(value:Number):void {
			throw new Error("Property height is read-only")
		}
		
	}

}