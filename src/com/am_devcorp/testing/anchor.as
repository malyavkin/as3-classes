package com.am_devcorp.testing
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class anchor extends Sprite
	{
		//radius
		public static const active_r:int = 10
		private var r:int
		//defines whether the ancor can be dragged by a mouse
		public var draggable:Boolean
		//the color of the ancor
		public var color:uint
		private var draggin:Boolean
		private var label:TextField
		public static const evName:String = "redraw"
		public function draw():void
		{
			graphics.clear()
			graphics.lineStyle(0,0,1,true)
			graphics.beginFill(this.color,1)
				graphics.drawCircle(0, 0, active_r)
			graphics.endFill()
		}
		
		public function anchor(x:int, y:int, label:String, color:uint = 0x1000000, active:Boolean = true)
		{
			if (color > 0xffffff) {
				color = uint(Math.random()*0xFFFFFF)
				
			}
			if (active) 
			{
				
				this.r = active_r
				this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown)
				this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp)
				this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
				this.color = color
			}
			else 
			{
				this.r = 5
				this.color = color
				this.alpha = 0.6
			}
			
			this.x = x
			this.y = y
			
			
			this.label = new TextField()
			this.label.selectable = false
			this.label.autoSize = TextFieldAutoSize.LEFT
			this.label.text = label
			this.label.x = 5
			this.label.y = 5
			addChild(this.label)
			draw()
		}
		
		private function onMouseMove(e:Event):void {
			if (draggin) {
				
				dispatchEvent(new Event(evName))
			}
		}
		private function onMouseDown(e:Event):void
		{
			this.startDrag(true)
			draggin = true
		}
		
		private function onMouseUp(e:Event):void
		{
			this.stopDrag()	
			draggin = false
		}

	}
}