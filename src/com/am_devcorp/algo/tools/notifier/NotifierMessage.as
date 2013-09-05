package com.am_devcorp.algo.tools.notifier {
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
    
    /**
     * ...
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class NotifierMessage extends Sprite {
        public var text:String
        public var type:uint
        private var timer:Timer
        internal var _uid:uint
        private const margin:Number = 20
        
        public function NotifierMessage(textString:String, msgType:uint, uid:uint, showTimeout:uint, enforcedWidth:Number=-1) {
            text = textString
            type = msgType
            
            timer = new Timer(showTimeout, 1)
            _uid = uid
            addEventListener(Event.ADDED_TO_STAGE, on_ADDED_TO_STAGE)
            ///drawin'
            var width:uint = enforcedWidth == -1 ? 400 : enforcedWidth
            var tf:TextField = new TextField()
            tf.width = width - 2 * margin
            tf.x = margin
            tf.y = margin
            tf.wordWrap = true
            tf.text = textString
            tf.textColor = 0xffffff
			//tf.embedFonts = true
			
            var height = 2 * margin + tf.textHeight
            this.graphics.lineStyle(2, 0x4c4c4c, 1, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER)
            this.graphics.beginFill(0x222222)
            this.graphics.drawRect(0, 0, width, height)
            
            addChild(tf)
        
        }
        
        private function on_PRESS():void {
        
        }
        
        private function on_ADDED_TO_STAGE(e:Event):void {
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, on_TIMER_COMPLETE)
            timer.start()
        }
        
        public function get uid():uint {
            return _uid
        }
        
        private function on_TIMER_COMPLETE(e:Event):void {
            var e:Event = new Event("remove_me_please")
            dispatchEvent(e)
        }
    }

}