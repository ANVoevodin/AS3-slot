package buttons {
	import graph.buttons.*;
	
	/**
	 * Класс кнопки для прокручивания слота
	 * @author 2Bob Анатолий Воеводин
	 */
	public class BtnSpin extends SimpleButton {
		private var _canSpin:Boolean;
		
		public function BtnSpin() {
			super(new graph.buttons.BtnSpin());
			setSpin();
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/** Устанавливает текст на кнопке, который означает прокрутку слота */
		public function setSpin():void {
			text = "SPIN";
			_canSpin = true;
		}
		/** Устанавливает текст на кнопке, который означает остановку слота */
		public function setStop():void {
			text = "STOP";
			_canSpin = false;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		/** Меняет текст на кнопке */
		public function set text(value:String):void {
			_mc.labelTF.text = value;
		}
		
	}

}