package com.am_devcorp 
{
	
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	import flash.display.BitmapData
	import com.adobe.images.PNGEncoder
	import flash.filesystem.FileStream
	import flash.filesystem.File
	public class Utils 
	{
		public static function savePNG(path:String, bd:BitmapData):void {
			var fs:FileStream = new FileStream()
			var file:File = new File(path)
			fs.open(file, "write")
			fs.writeBytes(PNGEncoder.encode(bd))
			
		}	
		
		
	}

}