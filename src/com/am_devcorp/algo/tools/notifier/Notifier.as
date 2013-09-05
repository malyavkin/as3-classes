package com.am_devcorp.algo.tools.notifier {
    import flash.geom.Point
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class Notifier {
        private static var msgStack:Vector.<String>;
        private static var timeout:uint;
        public static const SUCCESS:uint = 0
        public static const WARNING:uint = 1
        public static const FAULT:uint = 2
        public static const MESSAGE:uint = 100
        
        public function Notifier(timeout:uint) {
            this.timeout = timeout;
            msgStack = new Vector.<String>;
        }
        
        public static function notify(message:String, type:uint):void {
            if (!msgStack) {
                Notifier(10000)
            } else {
                msgStack.push(message)
            }
        
        }
    }

}