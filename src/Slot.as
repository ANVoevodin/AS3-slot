package {
	import content.combinations.Combination;
	import content.combinations.Combinations;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import gs.TweenLite;
	/**
	 * ...
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Slot extends Sprite {
		/** Контейнер для всех колонок, который скрывает лишнее посредством маски в IDE */
		private var _colsMc:Sprite;
		/** Первая колонка слота */
		private var _col1:Col;
		/** Вторая колонка слота */
		private var _col2:Col;
		/** Третья колонка слота */
		private var _col3:Col;
		/** Успешно собранные комбинации после последнего спина (массив из ID комбинаций) */
		private var _combinations:Vector.<int>;
		/** Протекает ли сейчас эффект собранных комбинаций */
		private var _isShowingCombinations:Boolean;
		
		/** Позиции на экране всех комбинаций (ассоциативный массив { idComb: new Point }) */
		private var _combinationsPos:Object;
		
		/** Событие возникает, когда слот прокрутился успешно и нужно обработать результат */
		public static const EVENT_ENDED:String = "slot_ended";
		
		public function Slot() {
			_colsMc = colsMc as Sprite;
			_col1 = new Col();
			_col2 = new Col();
			_col3 = new Col();
			_combinations = new Vector.<int>;
			setCombinationsPos();
			
			_col2.x = 153;
			_col3.x = 304;
			
			_colsMc.addChild(_col1);
			_colsMc.addChild(_col2);
			_colsMc.addChild(_col3);
			
			_col3.addEventListener(Col.EVENT_ENDED, onSpinEnded);
		}
		
		//-------------------------------------EVENTS--------------------------------------
		/** Спин слота закончился */
		private function onSpinEnded(e:Event):void {
			var icons:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
			var c1Icons:Vector.<int> = _col1.iconsIDs;
			var c2Icons:Vector.<int> = _col2.iconsIDs;
			var c3Icons:Vector.<int> = _col3.iconsIDs;
			icons.push(Vector.<int>([c1Icons[0], c2Icons[0], c3Icons[0]]));
			icons.push(Vector.<int>([c1Icons[1], c2Icons[1], c3Icons[1]]));
			icons.push(Vector.<int>([c1Icons[2], c2Icons[2], c3Icons[2]]));
			_combinations = Combinations.getCombinationsByIconsIDs(icons);
			showCombinations();
			dispatchEvent(new Event(EVENT_ENDED));
		}
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		/** Показывает визуально все комбинации */
		private function showCombinations():void {
			/** Функция убирает все комбинации и начинает их показывать по очереди */
			function mainShowed():void {
				i = 0;
				while (i < len) {
					combGraph[i].visible = false;
					i++;
				}
				//если комбинация не одна, то делаем небольшую паузу после того как удалили все комбинации и перед тем, как покажем их поочереди
				//а если одна, то сразу переходим к функции, которая очистит экран от эффекта
				if (len > 1) TweenLite.to(this, 0.25, { onComplete: turn, onCompleteParams: [0] });
				else end();
			}
			
			/** Функция показывает по очереди все комбинации начиная с переданного индекса (путем вызова самой себя) */
			function turn(i:int):void {
				//если это не первая комбинация, то берем предыдущую и убираем ей видимость (т.к. скорее всего до этого она была видима)
				if (i > 0) combGraph[i - 1].visible = false;
				//если комбинаций уже нет, то удаляем все комбинации заканчивая эффект
				if (i >= len) end();
				else {
					//если комбинации ещё есть, то показываем текущую и ставим таймер до следующего вызова
					combGraph[i].visible = true;
					TweenLite.to(this, 0.5, { "onComplete": turn, "onCompleteParams": [i + 1] });
				}
			}
			
			/** Удаляет все комбинации и говорит о том, что эффект закончен */
			function end():void {
				removeChild(combCont); //удаляем весь контейнер со всеми комбинациями
				_isShowingCombinations = false; //говорим о том, что показ эффекта закончен и можно дальше спинить
			}
			
			//если комбинаций нет, то просто ничего не делаем
			if (_combinations.length < 1) return;
			
			_isShowingCombinations = true;
			var combGraph:Vector.<Combination> = new Vector.<Combination>; //все спрайты комбинацией которые сейчас будут созданы
			var i:int = 0;
			var len:int = _combinations.length;
			var combCont:Sprite = new Sprite(); //сюда складируем все комбинации
			var comb:Combination; //временная переменная, куда в цикле будем класть комбинации
			var combPos:Point; //временная переменная, куда в цикле будем класть позиции комбинаций
			while (i < len) {
				comb = new Combination(_combinations[i]);
				combPos = _combinationsPos[_combinations[i]];
				combGraph.push(comb);
				comb.x = combPos.x;
				comb.y = combPos.y;
				combCont.addChild(comb);
				i++;
			}
			addChild(combCont);
			TweenLite.to(this, 1, { "onComplete": mainShowed });
			
			_isShowingCombinations = true;
		}
		
		/** Устанавливает значения в ассоц. массив позиций комбинаций */
		private function setCombinationsPos():void {
			_combinationsPos = {};
			_combinationsPos[Combinations.COM_LINE_1] = new Point(87, 51);
			_combinationsPos[Combinations.COM_LINE_2] = new Point(87, 153);
			_combinationsPos[Combinations.COM_LINE_3] = new Point(87, 256);
			_combinationsPos[Combinations.COM_DIAG_1] = new Point(87, 51);
			_combinationsPos[Combinations.COM_DIAG_2] = new Point(87, 51);
		}
		
		//-------------------------------------PUBLIC--------------------------------------
		/** Прокрутить слот */
		public function spin():void {
			if (canSpin) {
				//_col1.spin(5);
				//_col2.spin(6);
				//_col3.spin(7);
				_col1.spin(10);
				_col2.spin(30);
				_col3.spin(50);
			}
		}
		
		/** Останавливает кручение слота */
		public function stop():void {
			_col1.stop();
			_col2.stop();
			_col3.stop();
		}
		
		public function dispose():void {
			_col3.removeEventListener(Col.EVENT_ENDED, onSpinEnded);
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		/** Успешно собранные комбинации после последнего спина (массив из ID комбинаций) */
		public function get combinations():Vector.<int> {
			return _combinations;
		}
		
		/** Можно ли в данный момент крутить слот */
		public function get canSpin():Boolean {
			//мы можем крутить слот тогда, когда показ выиграшных линий закончен и ни одна из колонок не крутится
			return !_isShowingCombinations && !_col1.isSpinning && !_col2.isSpinning && !_col3.isSpinning;
		}
		
		/** Крутится ли в данный момент слот */
		public function get isSpinning():Boolean {
			//мы можем крутить слот тогда, когда показ выиграшных линий закончен и ни одна из колонок не крутится
			return _col1.isSpinning || _col2.isSpinning || _col3.isSpinning;
		}
		
	}

}