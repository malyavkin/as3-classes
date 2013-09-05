package com.am_devcorp.algo.game.control {
    import com.am_devcorp.algo.game.control.InputEvent;
    import flash.events.EventDispatcher;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    /**
     * Регистрирует нажатия/отжатия стрелок на клавиатуре и хранит их. Удобно для геймдева.
     * @author Alexey Malyavkin <a@malyavk.in>
     */
    public class Input extends EventDispatcher {
        public var up:Boolean
        public var down:Boolean
        public var left:Boolean
        public var right:Boolean
        public var z:Boolean
        public var x:Boolean
        public var c:Boolean
        
        public function releaseAll():void {
            up = false
            down = false
            left = false
            right = false
            z = false
            x = false
            c = false
        }
        
        public function Input():void {
        
        }
        
        public function inputHandler(e:KeyboardEvent):void {
            switch (e.type) {
                case KeyboardEvent.KEY_DOWN: 
                    toggle(e, true)
                    dispatchEvent(new InputEvent(InputEvent.PRESS, e.keyCode))
                    break;
                case KeyboardEvent.KEY_UP: 
                    toggle(e, false)
                    dispatchEvent(new InputEvent(InputEvent.RELEASE, e.keyCode))
                    break;
                default: 
            }
        }
        
        private function toggle(e:KeyboardEvent, pressed:Boolean):void {
            switch (e.keyCode) {
                case Keyboard.UP: 
                    up = pressed
                    break;
                case Keyboard.DOWN: 
                    down = pressed
                    break;
                case Keyboard.LEFT: 
                    left = pressed
                    break;
                case Keyboard.RIGHT: 
                    right = pressed
                    break;
                case Keyboard.Z: 
                    z = pressed
                    break;
                case Keyboard.X: 
                    x = pressed
                    break;
                case Keyboard.C: 
                    c = pressed
                    break;
                default: 
            }
        }
    
    }

}