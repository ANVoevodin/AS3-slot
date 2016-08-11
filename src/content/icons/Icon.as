package content.icons {
	import flash.display.Sprite;
	import graph.Icons;
	
	/**
	 * Класс иконки (каждая новая иконка в игре это экземляр этого класса)
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Icon extends Sprite {
		/** ID иконки */
		private var _id:int;
		/** Спрайт иконки */
		private var _sprite:Sprite;
		
		/**
		 * Класс иконки (каждая новая иконка в игре это экземляр этого класса)
		 * @param	id ID иконки
		 */
		public function Icon(id:int) {
			change(id);
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/**
		 * Изменить ID иконки на указанный
		 * @param	id Новый ID для иконки
		 */
		public function change(id:int):void {
			if (_sprite && contains(_sprite)) removeChild(_sprite);
			_id = id;
			_sprite = graph.Icons.getItem(id);
			addChild(_sprite);
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		/** ID иконки */
		public function get id():int {
			return _id;
		}
		
	}

}