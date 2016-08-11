package content.combinations {
	/**
	 * ...
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Combinations {
		/** Комбинация - первая горизонтальная линия */
		public static const COM_LINE_1:int = 1;
		/** Комбинация - вторая горизонтальная линия */
		public static const COM_LINE_2:int = 2;
		/** Комбинация - третья горизонтальная линия */
		public static const COM_LINE_3:int = 3;
		/** Комбинация - диагональная линия с левого-верхнего угла в нижний-правый */
		public static const COM_DIAG_1:int = 4;
		/** Комбинация - диагональная линия с правого-верхнего угла в нижний-левый */
		public static const COM_DIAG_2:int = 5;
		
		public function Combinations() {
			
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/**
		 * Получить ID всех успешных комбинацией по переданному 3х3 массиву ID-шников
		 * @param	data Массив 3x3 из ID иконок, где data[0] - первая строка, data[1] - вторая и т.д.
		 */
		public static function getCombinationsByIconsIDs(data:Vector.<Vector.<int>>):Vector.<int> {
			var ret:Vector.<int> = new Vector.<int>;
			//проверяем всевозможные комбинации
			if (data[0][0] == data[0][1] && data[0][0] == data[0][2]) ret.push(COM_LINE_1);
			if (data[1][0] == data[1][1] && data[1][0] == data[1][2]) ret.push(COM_LINE_2);
			if (data[2][0] == data[2][1] && data[2][0] == data[2][2]) ret.push(COM_LINE_3);
			if (data[0][0] == data[1][1] && data[0][0] == data[2][2]) ret.push(COM_DIAG_1);
			if (data[0][2] == data[1][1] && data[0][2] == data[2][0]) ret.push(COM_DIAG_2);
			return ret;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}

}