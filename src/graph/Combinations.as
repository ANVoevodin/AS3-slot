package graph {
	import flash.display.Sprite;
	import content.combinations.Combinations;
	import graph.combinations.*;
	/**
	 * Класс для удобного получения графики комбинаций
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Combinations {
		
		public function Combinations() {
			
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/**
		 * Получить графику комбинации по её ID
		 * @param	id ID комбинации
		 */
		public static function getItem(id:int):Sprite {
			var ret:Sprite;
			switch (id) {
				case content.combinations.Combinations.COM_LINE_1:
					ret = new graph.combinations.ComLine1();
					break;
				case content.combinations.Combinations.COM_LINE_2:
					ret = new graph.combinations.ComLine2();
					break;
				case content.combinations.Combinations.COM_LINE_3:
					ret = new graph.combinations.ComLine3();
					break;
				case content.combinations.Combinations.COM_DIAG_1:
					ret = new graph.combinations.ComDiag1();
					break;
				case content.combinations.Combinations.COM_DIAG_2:
					ret = new graph.combinations.ComDiag2();
					break;
			}
			return ret;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}

}