package com.am_devcorp.algo.graphics.render {
	import com.am_devcorp.Utils
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Histogram {
		
		public function Histogram(data:Vector.<uint>, path:String){
			var sum:uint
			for (var j:int = 0; j < data.length; j++){
				sum += data[j];
			}
			
			const IMAGE_HEIGHT:uint = 1001
			const IMAGE_WIDTH:uint = data.length * 2 + 1
			var hscale:Number = (IMAGE_HEIGHT / sum)
			var img:BitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT)
			for (var m:int = 0; m < IMAGE_HEIGHT; m++){
				for (var l:int = 0; l < IMAGE_WIDTH; l++){
					var color:uint = 0xFFFFFFFF
					
					//every 5%
					if ((IMAGE_HEIGHT - m) % 50 == 0){
						color = 0xffff8888
					}
					//every 10%
					if ((IMAGE_HEIGHT - m) % 100 == 0){
						color = 0xffff0000
					} else if ((l / 2) % 20 == 0){
						color = 0xffff0000
					}
					
					if (l % 2 == 1){
						if (data[(l - 1) / 2] * hscale >= (1000 - m)){
							color = 0xff000000
						}
					}
					img.setPixel32(l, m, color)
					
				}
			}
			Utils.savePNG(path, img)
		
		}
	
	}

}