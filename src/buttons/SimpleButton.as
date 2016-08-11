package buttons {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 2Bob Анатолий Воеводин
	 */
	public class SimpleButton extends Sprite {
		/** Мувик кнопки */
		protected var _mc:MovieClip;
		
		public function SimpleButton(mc:MovieClip) {
			_mc = mc;
			_mc.stop();
			addChild(_mc);
			buttonMode = useHandCursor = true;
			_mc.mouseChildren = _mc.mouseEnabled = false;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		//-------------------------------------EVENTS--------------------------------------
		private function onMouseOver(e:MouseEvent):void {
			_mc.gotoAndStop(2);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			_mc.gotoAndStop(1);
		}
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		
		//-------------------------------------PUBLIC--------------------------------------
		/** Очистить все ссылки объекта */
		public function dispose():void {
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeChild(_mc);
			_mc = null;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}

}