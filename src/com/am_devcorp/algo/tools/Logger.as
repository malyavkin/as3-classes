package com.am_devcorp.algo.tools {
	import adobe.utils.CustomActions;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode
	import flash.utils.Timer
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class Logger {
		private static var targ:File
		private static var t:Timer
		//private var fs:FileStream
		private static var notes:String
		private static var silent:Boolean
		public function Logger(f:File) {
			targ = f
			t = new Timer(1000);
			t.addEventListener(TimerEvent.TIMER,onTimer)
			notes = ""
			t.start()
			
		}
		private static function enforce_flush():void {
			onTimer()
		}
		private static function onTimer(e:TimerEvent=null):void {
			if (targ) {
				if (notes.length) {
					var fs:FileStream = new FileStream()
					if (targ.exists) {
						fs.open(targ, FileMode.APPEND)					
					} else {
						fs.open(targ, FileMode.WRITE)					
					}
					fs.writeUTFBytes(notes)
					fs.close()
					notes = ""
				}
			}
			
		}
		public static function purgeLogs():void {
			if (targ as File) {
				if (targ.exists) {
					targ.deleteFile()					
				}
			}
		}
		public static function log(...rest):void {
			var s:String = rest.join(" ")
			var a:Array = s.split("\n")
			for (var i:int = 0; i < a.length; i++) {
				trace("l:",a[i])
			}
			notes+=s+"\n"
		}
			

	}

}