package com.am_devcorp.algo.graphics.render.rasterstage {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class MultiframeSprite extends RasterSprite {
		protected var currentFrame:uint
		protected var numFrames:uint
		private var framesBitmap:BitmapData
		
		public function MultiframeSprite(width:uint, height:uint, frames:Vector.<BitmapData>){
			super(width, height);
			initFrames(frames)
		}
		
		private function initFrames(frames:Vector.<BitmapData>):void {
			var totalWidth:uint;
			for each (var i:BitmapData in frames){
				totalWidth += i.width;
				if (i.height != this.height){
					throw new ArgumentError("Incorrect bitmap height");
				}
				if (totalWidth % this.width){
					throw new Error("Incorrect bitmap width");
				}
				
			}
		
			framesBitmap = new BitmapData(totalWidth, this.height, true, 0);
			numFrames = totalWidth / this.width;
			var hCaret:uint
			for (var j:int = 0; j < frames.length; j++){
				framesBitmap.copyPixels(frames[j], frames[j].rect, new IntPoint(hCaret, 0).v, null, null, true);
				hCaret += frames[j].width;
			}
		}
		
		override public function getPicture():BitmapData {
			
			self.lock()
				self.fillRect(self.rect, 0)
				self.copyPixels(framesBitmap, new Rectangle(this.width * currentFrame, 0, this.width, this.height), new IntPoint().v, null, null, true)
			self.unlock()
			return self
		}
		
		public function nextFrame():void{
			currentFrame++
			if (currentFrame >= numFrames){
				currentFrame = 0
			}
		}
		
		public function prevFrame():void{
			currentFrame--
			if (currentFrame <= 0){
				currentFrame = numFrames - 1
			}
		}
		
		public function goto(frame:uint):void {
			if (frame >= numFrames){
				throw new ArgumentError("Frame #" + frame + " out of bounds " + numFrames)
			}
			currentFrame = frame
		}
	
	}

}