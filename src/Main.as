package{
	import buttons.BtnSpin;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import graph.NotEnough;
	import gs.TweenLite;
	import gs.easing.Back;
	import gs.easing.Linear;
	import storage.Storage;
	
	/**
	 * ...
	 * @author 2Bob Анатолий Воеводин
	 */
	public class Main extends Sprite {
		/** Объект слота */
		private var _slot:Slot;
		/** Кнопка прокрутки */
		private var _btnSpin:BtnSpin;
		/** Текстовое поле баланса */
		private var _balanceTF:TextField;
		/** Текстовое поле выиграша */
		private var _winTF:TextField;
		/** Текстовое поле ставки */
		private var _betTF:TextField;
		/** Спрайт, который отображается тогда, когда недостаточно средств для спина */
		private var _notEnough:Sprite;
		
		/** Данные игрока */
		public static var STORAGE:Storage;
		
		public static var SW:int = 600;
		public static var SH:int = 450;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//-------------------------------------EVENTS--------------------------------------
		/** Клик по кнопке спина */
		private function onSpinClick(e:MouseEvent):void {
			spin();
		}
		
		/** Обработчик события изменения баланса игрока */
		private function onBalanceIsChanged(e:Event):void {
			updateTF();
		}
		
		/** Обработчик события изменения выигрыша игрока */
		private function onWinIsChanged(e:Event):void {
			updateTF();
		}
		
		/** Обработчик события успешного прокручивания слота */
		private function onSlotEnded(e:Event):void {
			var win:int = _slot.combinations.length * Settings.BET;
			STORAGE.win = win;
			_btnSpin.setSpin();
		}
		
		/** Обработчик отжатых клавиш */
		private function onKeyUp(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) spin();
		}
		
		//--------------------------------PRIVATE/PROTECTED--------------------------------
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SW = stage.stageWidth;
			SH = stage.stageHeight;
			create();
			updateTF();
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/** Крутить слот если остановлен или оставить если крутится */
		private function spin():void {
			var canSpin:Boolean = _slot.canSpin; //можем ли мы крутить слот
			var isSpinning:Boolean = _slot.isSpinning; //крутиться ли слот в данный момент
			
			//если какой-то выигрыш есть и при этом слот может крутиться дальше.
			//почему тут проверка canSpin: если мы показываем выигрышные линии и в этот момент нажимаем на
			//кнопку spin, выигрыш переходит в баланс, а такое на этоп этапе нам не нужно. Выигрыш в баланс
			//должен переходить при нормальном спине
			if (canSpin && STORAGE.win > 0) {
				STORAGE.addBalance(STORAGE.win);
				STORAGE.win = 0;
			}
			
			var hasEnough:Boolean = STORAGE.hasBalance(Settings.BET); //флаг говорящий о том, хватает ли на балансе средств
			if (canSpin && hasEnough) {
				_slot.spin();
				_btnSpin.setStop();
				STORAGE.takeBalance(Settings.BET);
			} else if (!canSpin && isSpinning) {
				_slot.stop();
				_btnSpin.setSpin();
			} else if (!hasEnough) {
				showNotEnough();
			}
		}
		
		/** Обновить текстовые поля на экране */
		public function updateTF():void {
			balanceTF.text = String(STORAGE.balance);
			winTF.text = String(STORAGE.win);
			betTF.text = String(Settings.BET);
		}
		
		/** Создать и отобразить все элементы */
		private function create():void {
			if (!STORAGE) STORAGE = new Storage();
			STORAGE.addEventListener(Storage.EVENT_WIN_IS_CHANGED, onWinIsChanged);
			STORAGE.addEventListener(Storage.EVENT_BALANCE_IS_CHANGED, onBalanceIsChanged);
			
			_slot = new Slot();
			_slot.x = SW - _slot.width >> 1;
			_slot.y = 70;
			_slot.addEventListener(Slot.EVENT_ENDED, onSlotEnded);
			addChild(_slot);
			
			_btnSpin = new BtnSpin();
			_btnSpin.x = SW - _btnSpin.width >> 1;
			_btnSpin.y = 386;
			_btnSpin.addEventListener(MouseEvent.CLICK, onSpinClick);
			addChild(_btnSpin);
		}
		
		/** Показать табличку "Недостаточно средств" */
		private function showNotEnough():void {
			function pause():void { TweenLite.to(_notEnough, 1, { "onComplete": hide }); }
			function hide():void {
				TweenLite.to(_notEnough, 0.2, {
					"y": 0,
					"alpha": 0,
					"ease": Linear.easeIn,
					"onComplete": remove
				});
			}
			function remove():void {
				if (_notEnough && contains(_notEnough)) removeChild(_notEnough);
			}
			
			if (!_notEnough) _notEnough = new graph.NotEnough();
			_notEnough.alpha = 0;
			_notEnough.x = SW;
			_notEnough.y = SH >> 1;
			addChild(_notEnough);
			TweenLite.to(_notEnough, 0.2, {
				"x": SW >> 1,
				"alpha": 1,
				"ease": Back.easeOut,
				"onComplete": pause
			});
		}
		
		//-------------------------------------PUBLIC--------------------------------------
		/** Освободить память от настоящего объекта */
		public function dispose():void {
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_btnSpin.removeEventListener(MouseEvent.CLICK, onSpinClick);
			STORAGE.removeEventListener(Storage.EVENT_WIN_IS_CHANGED, onWinIsChanged);
			STORAGE.removeEventListener(Storage.EVENT_BALANCE_IS_CHANGED, onBalanceIsChanged);
			
			_slot.removeEventListener(Slot.EVENT_ENDED, onSlotEnded);
			_slot.dispose();
		}
		
		//---------------------------------GETTERS/SETTERS---------------------------------
		
	}
	
}