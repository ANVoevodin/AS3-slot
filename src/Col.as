package {
	import content.icons.Icon;
	import content.icons.Icons;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import gs.TweenLite;
	import gs.easing.Linear;
	
	/**
	 * Колонка с четырьмя иконками по вертикали (четвертая существует для анимации).
	 * Самая первая иконка скрыта и находится в отрицательных координатах по Y.
	 * Вторая иконка - визуально первая и стоит в нулевых координах по Y, именно с неё
	 * начинается счёт трёх иконок.
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Col extends Sprite {
		/** Крутиться ли колонка прямо сейчас */
		private var _isSpinning:Boolean;
		/** Если нужно как можно раньше остановить колонку, то нужно поставить этот флаг в true */
		private var _needStop:Boolean;
		
		/** Массив всех четырех иконок иконок */
		private var _icons:Vector.<Icon>;
		/** В каких координатах должны находится иконки */
		private var _positions:Vector.<Point>;
		/** Количество иконок в колонке */
		private const COUNT_ICONS:int = 4;
		
		/** Событие, возникающее когда колонка самостоятельно закончила своё кручение */
		public static const EVENT_ENDED:String = "event_col_is_ended";
		
		public function Col() {
			_icons = new Vector.<Icon>;
			createPositions();
			
			fill();
		}
		
		//-------------------------------------EVENTS--------------------------------------
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		/** Заполняет пустую колонку иконками */
		private function fill():void {
			var i:int = 0;
			var len:int = COUNT_ICONS;
			var icon:Icon;
			while (i < len) {
				icon = new Icon(Icons.getRandomID());
				_icons.push(icon);
				addChild(icon);
				i++;
			}
			setSlotsDefaultPositions();
		}
		
		/** Создать массив с позициями всех иконок */
		private function createPositions():void {
			_positions = Vector.<Point>([
				new Point(0, -98),
				new Point(0, 0),
				new Point(0, 98),
				new Point(0, 196),
				new Point(0, 292) //последние пятые координаты для анимации последней иконки
			]);
		}
		
		/**
		 * Проанимировать прокрутку колонки
		 * @param	itemsCount Сколько осталось иконок до конца прокрутки
		 */
		private function anim(itemsCount:int):void {
			var i:int = 0;
			var len:int = _icons.length;
			var icon:Icon;
			var pos:Point;
			var time:Number = 0.06;
			while (i < len) {
				icon = _icons[i];
				pos = _positions[i + 1];
				TweenLite.to(icon, time, {
					"y": pos.y,
					"ease": Linear.easeNone
				});
				i++;
			}
			setTimeout(animOnComplete, time * 1000, itemsCount);
			_isSpinning = true;
		}
		
		/**
		 * Функция вызывается после того, как очередная прокрутка дошла до конца
		 * @param	itemsCount Сколько осталось иконок до конца прокрутки
		 */
		private function animOnComplete(itemsCount:int):void {
			var newID:int = Icons.getRandomID(); //генерируем ID для следующей иконки
			setSlotsDefaultPositions(); //возвращаем иконки обратно на свои места
			shiftAllSlots(newID); //сдвигаем ID иконок на одну
			itemsCount--; //одна прокрутка прошла, уменьшаем счетчик
			if (!_needStop && itemsCount > 0) anim(itemsCount); //если счетчик всё ещё не нулевой, то крутим ещё раз
			else {
				_isSpinning = false;
				_needStop = false;
				dispatchEvent(new Event(EVENT_ENDED));
			}
		}
		
		/**
		 * Функция сдвигает все ID у иконок вниз на 1, и самому нижнему присваивает newID
		 * @param	newID ID иконки, который будет присвоен самому нижнему скрытому спрайту
		 */
		private function shiftAllSlots(newID:int):void {
			var i:int = _icons.length;
			
			//начиная с первой, каждая иконка берет ID следующей, а последняя берет новый ID
			while (--i > 0) {
				_icons[i].change(_icons[i - 1].id);
			}
			_icons[0].change(newID); //последняя иконка берет новый ID
		}
		
		/** Поставить все слоты в свои позиции без анимации */
		private function setSlotsDefaultPositions():void {
			var i:int = 0;
			var len:int = _icons.length;
			var icon:Icon;
			var pos:Point;
			while (i < len) {
				icon = _icons[i];
				pos = _positions[i];
				icon.x = pos.x;
				icon.y = pos.y;
				addChild(icon);
				i++;
			}
		}
		
		//-------------------------------------PUBLIC--------------------------------------
		/**
		 * Прокрутить всю колонку на указанное количество иконок
		 * @param	iconsCount Сколько иконок прокрутить прежде чем остановиться
		 */
		public function spin(iconsCount:int):void {
			anim(iconsCount);
		}
		
		/** Остановить кручение колонки */
		public function stop():void {
			if (isSpinning) _needStop = true;
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		/** Получить три ID иконки (сверху вниз), которые отображаются в колонке на данный момент */
		public function get iconsIDs():Vector.<int> {
			var ret:Vector.<int> = new Vector.<int>;
			var i:int = 1; //начинаем с единици, так как первая иконка у нас скрыта за слотом
			var len:int = _icons.length;
			while (i < len) {
				ret.push(_icons[i].id);
				i++;
			}
			return ret;
		}
		
		/** Крутиться ли колонка прямо сейчас */
		public function get isSpinning():Boolean {
			return _isSpinning;
		}
		
	}

}