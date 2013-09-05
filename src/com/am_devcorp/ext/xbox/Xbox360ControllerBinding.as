package com.am_devcorp.ext.xbox {
	import flash.desktop.NativeProcess;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent
	import flash.desktop.NativeProcessStartupInfo
	import flash.filesystem.File
	import flash.utils.ByteArray
	import flash.events.EventDispatcher
    
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	import flash.desktop.NativeProcess
	public class Xbox360ControllerBinding extends EventDispatcher{
		private var nativeProcessStartupInfo:NativeProcessStartupInfo;
		public var XBind:NativeProcess
        public var i:uint
		public function Xbox360ControllerBinding() {

            nativeProcessStartupInfo = new NativeProcessStartupInfo();
            var file:File = File.applicationDirectory.resolvePath("XBind.exe");
			//var file:File = new File("c:\\windows\\system32\\cmd.exe")
            nativeProcessStartupInfo.executable = file;
			
			XBind = new NativeProcess();
            XBind.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            XBind.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			XBind.addEventListener(IOErrorEvent.STANDARD_INPUT_IO_ERROR, onSTDINioErr)
			XBind.addEventListener(NativeProcessExitEvent.EXIT, onExit)
			XBind.addEventListener(Event.STANDARD_OUTPUT_CLOSE, onOutputClose)
			
            XBind.start(nativeProcessStartupInfo);
			
		}
		
		private function onOutputClose(e:DataEvent):void {
			trace("stdout closed")
		}
		
		private function onErrorData(e:ProgressEvent):void {
			
			trace("3:e:",XBind.standardError.readUTFBytes(XBind.standardError.bytesAvailable))
		}
		
		private function onSTDINioErr(e:IOErrorEvent):void {
			if (XBind.running) {
				trace("Stdin failure, attempting to restart...")
				XBind.exit(true)
			}
		}
		
		private function onExit(e:NativeProcessExitEvent):void {
			trace("app unloaded, restarting...")
			XBind.start(nativeProcessStartupInfo)
		}
		private function onOutputData(event:ProgressEvent):void {
			
			var data:String = XBind.standardOutput.readUTFBytes(XBind.standardOutput.bytesAvailable);
			trace(i++ + "\ngot some:" + data)
			//dispatchEvent(new Event("xxx"))
			var strings:Array = data.split("\r\n\r\n")
			dispatchEvent(new XINPUT_STATE_Event(new XML(strings[0])))				
			
		}
		
		
		public function read(uJoyID:uint):void { 
			if (XBind.running) {
				
				var s:String = "read "+uJoyID+"\n"
				XBind.standardInput.writeUTFBytes(s)
			}
			else {
				trace("app not running!")
			}

		}
	}

}