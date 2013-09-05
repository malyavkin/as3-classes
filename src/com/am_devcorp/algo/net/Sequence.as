package com.am_devcorp.algo.net {
    import com.am_devcorp.algo.tools.Logger
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    import flash.net.URLLoaderDataFormat
    [Event(name="JobEvent.name",type="JobEvent")]
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class Sequence extends EventDispatcher {
        
        private var requests:Vector.<URLRequest>
        private var handlers:Vector.<String>
        private var uid:uint
        
        private var activeRequest:URLRequest
        private var activeHandler:String
        
        private var stream:URLLoader
        
        private var _totalJobs:uint
        private var _completedJobs:uint
        private var _successfullyCompletedJobs:uint
        
        public function Sequence() {
            requests = new Vector.<URLRequest>
            handlers = new Vector.<String>
            stream = new URLLoader()
            stream.dataFormat = URLLoaderDataFormat.BINARY
            
            stream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onhtpresponsestatus)
            stream.addEventListener(Event.COMPLETE, onJobComplete)
            stream.addEventListener(ProgressEvent.PROGRESS, onprogress)
            stream.addEventListener(IOErrorEvent.IO_ERROR, onIOError)
            _totalJobs = 0
            _completedJobs = 0
            _successfullyCompletedJobs = 0
        }
        
        private function getNewHandler():String {
            return String(uid++)
        }
        
        public function get queue():String {
            var res:String = ""
            var cnt:uint
            for each (var i:URLRequest in requests) {
                res += i.url + "\n"
                cnt++
            }
            res += "\nTotal: " + cnt + " entries are in the queue"
            return res
        }
		
		public function get totalJobs():uint {
			return _totalJobs;
		}
		
		public function get completedJobs():uint {
			return _completedJobs;
		}
		
		public function get successfullyCompletedJobs():uint {
			return _successfullyCompletedJobs;
		}
		
        private function onprogress(e:ProgressEvent):void {
            dispatchEvent(new JobProgressEvent(activeHandler, "fetching",activeRequest.url, e.bytesLoaded, e.bytesTotal))
        }
        
        
        public function addDownloadJob(info:URLRequest):String {
            var handler:String = getNewHandler()
            requests.push(info)
            handlers.push(handler)
            
			_totalJobs++
            return handler
        }
        
        public function launch():void {
            for (var i:int = 0; i < handlers.length; i++) {
				
                dispatchEvent(new JobProgressEvent(handlers[i], "queued",requests[i].url))
            }
            
            Logger.log("Started...")
            
            StartNewJob()
        
        }
        
        private function StartNewJob():void {
            if (stream) {
                if (handlers.length) {
                    
                    activeHandler = handlers.shift()
                    activeRequest = requests.shift()
                    
                    stream.load(activeRequest)
                    Logger.log("\nAttempting to download: ", activeRequest.url)
                } else {
                    onSequenceComplete()
                }
            } else {
                
            }
        }
        private function onhtpresponsestatus(e:HTTPStatusEvent):void {
            Logger.log("response:", e.responseURL, e.status, e.status == 200 ? "OK" : "NOT OK")
            if (e.status != 200) {
                stream.close()
                Logger.log("ZAT LOOKS BAD, I AINT ABLE TO DEAL WITH DIS SHIT")
                dispatchEvent(new JobProgressEvent(activeHandler, String(e.status),e.responseURL))
				
				_completedJobs++
                StartNewJob()
            }
        }

        private function onJobComplete(e:Event):void {
            
            Logger.log("Downloaded.")
            var ba:ByteArray = stream.data as ByteArray
            dispatchEvent(new JobProgressEvent(activeHandler, "done",activeRequest.url, ba.bytesAvailable, ba.bytesAvailable))
            dispatchEvent(new JobEvent(String(activeHandler), new Job(activeRequest.url, ba)))
            _completedJobs++
			_successfullyCompletedJobs++
			StartNewJob()
        }
        
        private function onSequenceComplete(e:Event = null):void {
            Logger.log("\n\nfukken saved =(^__^)=")
            dispatchEvent(new Event(Event.COMPLETE))
        }
        
        private function onIOError(e:IOErrorEvent):void {
            Logger.log("io! io!")
            dispatchEvent(new JobProgressEvent(activeHandler, "failure",activeRequest.url))
			_completedJobs++
			StartNewJob()
        }
    
    }

}