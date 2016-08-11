package graph {
	import flash.display.Sprite;
	import graph.icons.*;
	/**
	 * Класс для удобного получения графики иконок
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Icons {
		
		public function Icons() {
			
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/**
		 * Получить иконку по её ID
		 * @param	id ID иконки
		 */
		public static function getItem(id:int):Sprite {
			var ret:Sprite;
			switch (id) {
				case 1:
					ret = new graph.icons.Icon1();
					break;
				case 2:
					ret = new graph.icons.Icon2();
					break;
				case 3:
					ret = new graph.icons.Icon3();
					break;
				case 4:
					ret = new graph.icons.Icon4();
					break;
				case 5:
					ret = new graph.icons.Icon5();
					break;
			}
			return ret;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}

}