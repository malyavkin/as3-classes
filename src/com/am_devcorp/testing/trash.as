package com.am_devcorp.testing
{
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	import flash.display.Sprite;
	public class trash extends Sprite
	{
		public function trash(color:uint) 
		{
			draw(color)
		}
		public function draw(color:uint):void 
		{
			graphics.lineStyle(1, color)
			graphics.beginFill(0xFFFFFF)
			graphics.drawRect(0, 0, 40, 40)
		}
		
		
	}

}