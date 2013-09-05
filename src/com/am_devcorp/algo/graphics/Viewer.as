package com.am_devcorp.algo.graphics {
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Viewer extends Sprite{
			
		private var vmask:Sprite
		private var _pressed:Boolean
		
		private var thatSprite:Sprite
		private var k:Number
		
		private var WIDTH:Number
		private var HEIGHT:Number
		private var minx:Number;
		private var miny:Number;
		private var originalx:Number;
		private var originaly:Number;
		
		
		public function Viewer(width:Number, height:Number ) {
			
			WIDTH = width
			HEIGHT = height
			_pressed = false
			
			this.graphics.beginFill(0x808080);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
						
			vmask = new Sprite()
			vmask.graphics.beginFill(0);
			vmask.graphics.drawRect(0, 0, width, height);
			vmask.graphics.endFill();
			addChild(vmask)
			this.mask = vmask
			
			var pad:Sprite = new Sprite()
			pad.graphics.beginFill(0,0);
			pad.graphics.drawRect(0, 0, width, height);
			pad.graphics.endFill();
			addChildAt(pad,1)
			
			
			pad.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel)
			pad.addEventListener(MouseEvent.MOUSE_DOWN, onPress)
			pad.addEventListener(MouseEvent.MOUSE_UP, onRelease)
			pad.addEventListener(MouseEvent.MOUSE_MOVE, onMove)
			
			
		}
		
		
		public function load(s:Sprite):void {
			
			if (thatSprite) {
				removeChild(thatSprite)
			}
			thatSprite = s as Sprite
			k = Math.min( WIDTH / s.width , HEIGHT / s.height)
			minx = WIDTH - s.width
			miny = HEIGHT - s.height
			thatSprite.scaleX = k
			thatSprite.scaleY = k
			originalx = (WIDTH - thatSprite.width)/2
			originaly = (HEIGHT- thatSprite.height)/2
			thatSprite.x = originalx
			thatSprite.y = originaly
			addChildAt(thatSprite, 1)
			
			
		}
		private function onMove(e:MouseEvent):void {
			
			if (thatSprite.width > WIDTH || thatSprite.height > HEIGHT) {
				var desiredX:Number = ((WIDTH- thatSprite.width)*(e.localX/WIDTH ))
				var desiredY:Number = ((HEIGHT- thatSprite.height)*(e.localY/HEIGHT ))
				thatSprite.x = desiredX
				thatSprite.y = desiredY
			}
			
			
		}
		private function onRelease(e:MouseEvent):void {
			TweenMax.to(thatSprite, 0.1, {x:originalx, y:originaly, scaleX:k, scaleY:k, ease:Sine.easeOut});
		}
		
		private function onPress(e:MouseEvent):void {
				var newx:Number = (e.localX/WIDTH)*(WIDTH - thatSprite.width/k)
				var newy:Number = (e.localY/HEIGHT)*(HEIGHT- thatSprite.height/k)
				TweenMax.to(thatSprite, 0.1, {x:newx, y:newy, scaleX:1, scaleY:1, ease:Sine.easeOut});
			
		
		}
		private function onWheel(e:MouseEvent):void {
			if (e.delta>0) {
				//zoom in
			} else {
				//zoom out
			}
		}
		
	}

}