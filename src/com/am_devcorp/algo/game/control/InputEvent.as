package com.am_devcorp.algo.game.control {
	import flash.events.Event;
	/**
	 * Просто обёртка для стандартного Event с нужными параметрами
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	
	public class InputEvent extends Event{
		public static const RELEASE:String = "release";
		public static const PRESS:String = "press";
		public var key:uint
		/**
		 * 
		 * @param	type нажат/отжат, см. константы
		 * @param	key скан-код
		 */
		public function InputEvent (type:String,key:uint) {
			super(type)
			this.key = key
		}
		
	}

}