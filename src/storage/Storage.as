package storage {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Storage extends EventDispatcher {
		/** Баланс игрока */
		private var _balance:int;
		/** Последний выигрыш */
		private var _win:int;
		
		/** Событие вещается, когда баланс был изменен */
		public static const EVENT_BALANCE_IS_CHANGED:String = "event_balance_is_changed";
		/** Событие вещается, когда выиграшь был изменен */
		public static const EVENT_WIN_IS_CHANGED:String = "event_win_is_changed";
		
		public function Storage() {
			_balance = 50;
			_win = 0;
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/** Проверяет, есть ли в балансе указанная сумма */
		public function hasBalance(value:int):Boolean {
			return balance >= value;
		}
		
		/** Отнять указанное количество от баланса */
		public function addBalance(value:int):void {
			balance += value;
		}
		
		/** Отнять указанное количество от баланса */
		public function takeBalance(value:int):void {
			if (balance < value) throw new Error("На балансе не достаточно средств для снятия");
			balance -= value;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		/** Баланс игрока */
		public function get balance():int {
			return _balance;
		}
		public function set balance(value:int):void {
			var oldValue:int = _balance;
			_balance = value;
			//вещаем, что баланс изменился только в том случае, если передали число отличное от старого
			if (oldValue != value) dispatchEvent(new Event(EVENT_BALANCE_IS_CHANGED));
		}
		
		/** Последний выиграшь */
		public function get win():int {
			return _win;
		}
		public function set win(value:int):void {
			var oldValue:int = _win;
			_win = value;
			//вещаем, что выиграшь изменился только в том случае, если передали число отличное от старого
			if (oldValue != value) dispatchEvent(new Event(EVENT_WIN_IS_CHANGED));
		}
		
	}

}