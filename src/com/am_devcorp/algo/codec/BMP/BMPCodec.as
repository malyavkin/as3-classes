package com.am_devcorp.algo.codec.BMP {
	import flash.display.BitmapData;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class BMPCodec {
		private static const BI_RGB :uint = 0
		private static const BI_RLE8 :uint = 1
		private static const BI_RLE4 :uint = 2
		private static const BI_BITFIELDS :uint = 3
		private static const BI_JPEG :uint = 4
		private static const BI_PNG :uint = 5
		private static const BI_ALPHABITFIELDS :uint = 6
		private static const BMP_SIGNATURE_LE:uint = 0x4d42
		
		public static function Encode(img:BitmapData,bpp:uint=32,compression:uint = BI_RGB):FileStream {
			var f:FileStream = new FileStream()
			f.endian = Endian.LITTLE_ENDIAN
			f.writeShort(BMP_SIGNATURE_LE)
			
			
			
			return null
		}
		/**
		 * Decodes BMP file into BitmapData
		 * @param	f BMP file
		 * @param	printLevel 0 - nothing, 1 - errors 2 - messages and errors, 3 - everything;
		 * @return
		 */
		public static function Decode(f:FileStream, printLevel:uint= 0):BitmapData{
			// WORD -  16-bit unsigned int
			// DWORD - 32-bit unsigned int
			// LONG -  32-bit signed int
			var bm:BitmapData
			
			f.endian = Endian.LITTLE_ENDIAN
			try {
			///reading BITMAPFILEHEADER
				var bfHeader_offset  :uint = f.position
				var bfType           :uint = f.readUnsignedShort()  //WORD
				var bfSize           :uint = f.readUnsignedInt()    //DWORD
				var bfReserved1      :uint = f.readUnsignedShort()  //WORD
				var bfReserved2      :uint = f.readUnsignedShort()  //WORD
				var bfOffBits        :uint = f.readUnsignedInt()    //DWORD
				
			///reading BITMAPINFOHEADER
				var biHeaderOffset   :uint = f.position
				var biSize           :uint = f.readUnsignedInt()    //DWORD
				var biWidth          :int  = f.readInt()            //LONG
				var biHeight         :int  = f.readInt()            //LONG
				var biPlanes         :uint = f.readUnsignedShort()  //WORD
				var biBitCount       :uint = f.readUnsignedShort()  //WORD  *
				var biCompression    :uint = f.readUnsignedInt()    //DWORD *
				var biSizeImage      :uint = f.readUnsignedInt()    //DWORD
				var biXPelsPerMeter  :int  = f.readInt()            //LONG
				var biYPelsPerMeter  :int  = f.readInt()            //LONG
				var biClrUsed        :uint = f.readUnsignedInt()    //DWORD
				var biClrImportant   :uint = f.readUnsignedInt()    //DWORD
			///reading color table
				var colortable:ByteArray = new ByteArray()
				if (biClrUsed) {
					f.position = biHeaderOffset + biSize
					f.readBytes(colortable,0,4*biClrUsed)
				}
				if (printLevel >=3) {
					trace("    Color table length: 0x"+colortable.length+" bytes")
				}
				colortable.position = 0
			///reading raw image data	
				var imagedata:ByteArray = new ByteArray()
				f.position = bfHeader_offset+bfOffBits
				f.readBytes(imagedata, 0, biSizeImage)
				imagedata.position = 0
			///we don't need this now
				f.close()
			///uncompressing image data
				switch (biCompression) {
					case BI_RGB: 
						//there is no compression
					break;
					case BI_RLE8: 
					case BI_RLE4: 
					case BI_BITFIELDS: 
					case BI_JPEG: 
					case BI_PNG: 
					case BI_ALPHABITFIELDS: 
						throw new Error("Not implemented")
					break;
				default:
						throw new Error("Unknown compression")
				}
			///transcode to bmdata
				//seting up
				var abs_height:uint = Math.abs(biHeight)
				bm = new BitmapData(biWidth, abs_height, true, 0)
				var hcaret:int = abs_height - 1
				var d_hcaret:int = -1
				var padding:uint = (4-((biWidth*biBitCount/8)%4))%4
				//if (biHeight>0) {
				//	hcaret = 0
				//	d_hcaret = 1
				//}
				bm.lock()
				var i:int, j:int, A:uint, R:uint, G:uint, B:uint;
				switch (biBitCount) {
					case 0:
					case 1:
					case 2:
					case 4:
					case 8:
					case 16:
						throw new Error("Unknown bpp")
					break;
					case 24:
						A = 0xFF
						//3 means 3 bytes per pixel
						//4 - max padding
						for (i = 0; i < abs_height; i++) {
							//	hcaret = (abs_height -i-1)*rev+i*(1-rev)
							for (j = 0; j < biWidth; j++) {
								
								B = imagedata.readUnsignedByte()
								G = imagedata.readUnsignedByte()
								R = imagedata.readUnsignedByte()
								bm.setPixel32(j,hcaret,uint(A << 24 | R << 16 | G << 8 | B))
							}
							imagedata.position+=padding
							hcaret+=d_hcaret
						}
					break;
					case 32:
						for (i = 0; i < abs_height; i++) {
							//	hcaret = (abs_height -i-1)*rev+i*(1-rev)
							for (j = 0; j < biWidth; j++) {
								
								B = imagedata.readUnsignedByte()
								G = imagedata.readUnsignedByte()
								R = imagedata.readUnsignedByte()
								A = imagedata.readUnsignedByte()
								bm.setPixel32(j,hcaret,uint(A << 24 | R << 16 | G << 8 | B))
							}
							imagedata.position+=padding
							hcaret+=d_hcaret
						}
					break;
				default:
				}
				bm.unlock()
				if (printLevel>=2) {
					trace("2:Decode succeed; " + imagedata.bytesAvailable.toString(16)+" bytes left unread")
				}
			} catch (err:Error){
				trace("3:" + err.message)
				trace(err.getStackTrace())
			}
			return bm
		}
	}
}