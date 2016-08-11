package content.combinations {
	import flash.display.Sprite;
	import graph.Combinations;
	import graph.combinations.*;
	/**
	 * Класс определенной комбинации
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Combination extends Sprite {
		/** ID комбинации из констант класса content.combinations.Combinations */
		private var _id:int;
		/** Спрайт комбинации отображаемый на экране */
		private var _sprite:Sprite;
		
		/**
		 * Класс определенной комбинации
		 * @param	id ID комбинации из констант класса content.combinations.Combinations.
		 */
		public function Combination(id:int) {
			_sprite = graph.Combinations.getItem(id);
			addChild(_sprite);
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}

}