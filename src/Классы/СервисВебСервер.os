// Номер порта, который будет прослушивать TCPСервер
Перем ПортПрослушивания;

// Объект управляющий маршрутизацией запросов
Перем Маршрутизатор;

// Свойства маршрутов по умолчанию
Перем СвойстваМаршрутовПоУмолчанию;

// Создаёт экземпляр web сервера
//
// Параметры:
//   Порт - Число - Порт запуска веб сервера
//   СвойстваМаршрутов - Структура - Свойства маршрутов по умолчанию
//
Процедура ПриСозданииОбъекта(Порт = 5555, СвойстваМаршрутов)
	
	ПортПрослушивания = Порт;
	СвойстваМаршрутовПоУмолчанию = СвойстваМаршрутов;

КонецПроцедуры

// Выпоняет запуск web сервера и ожидает соединения, блокирует поток выполнения
//
// Параметры:
//   ФоноваяОбработка - Булево - Если Истина тогда обработка соединений будет происходить в фоновом задании
//
Процедура Запустить(ОбъектМаршрутизатора) Экспорт
	
	Маршрутизатор = ОбъектМаршрутизатора;
	ВебСервер = Новый ВебСервер(ПортПрослушивания);

	Лог.Информация("Сервер будет запущен по адресу: http://127.0.0.1:" + Строка(ПортПрослушивания)); // BSLLS:UsingHardcodeNetworkAddress-off
	
	ВебСервер.ДобавитьОбработчикЗапросов(ЭтотОбъект, "ОбработатьЗапрос");
	ВебСервер.Запустить();

КонецПроцедуры

Процедура ОбработатьЗапрос(Контекст, СледующийОбработчик) Экспорт
	
	Попытка
		
		МенеджерОбъектов = Приложение.МенеджерОбъектов();
		Перехватчики = МенеджерОбъектов.КлючиПерехватчиков();
		ОбъектыПерехватчиков = Новый Массив();
		ЗапросОтБраузера = ЗапросОтБраузера(Контекст.Запрос.Заголовки);

		Для Каждого КлючПерехватчика Из Перехватчики Цикл
			ОбъектыПерехватчиков.Добавить(МенеджерОбъектов.СоздатьОбъект(КлючПерехватчика));
		КонецЦикла;

		КонтекстЗапросаСтруктура = Новый Структура();
		КонтекстЗапросаСтруктура.Вставить("Запрос", Контекст.Запрос);
		КонтекстЗапросаСтруктура.Вставить("Ответ", Контекст.Ответ);
		КонтекстЗапросаСтруктура.Вставить("ЗапросОтБраузера", ЗапросОтБраузера);
		КонтекстЗапросаСтруктура.Вставить("Сеанс", Неопределено);
		КонтекстЗапросаСтруктура.Вставить("Данные", Новый Структура());
		КонтекстЗапросаСтруктура.Вставить("Формы", Новый КоллекцияФорм());
		КонтекстЗапросаСтруктура.Вставить("ТекущаяФорма", Неопределено);
		КонтекстЗапросаСтруктура.Вставить("АдресПеренаправления", "");

		Если КонтекстЗапросаСтруктура.ЗапросОтБраузера Тогда
			МенеджерСеансов = Приложение.МенеджерСеансов();
			КонтекстЗапросаСтруктура.Сеанс = МенеджерСеансов.ОпределитьСеанс(КонтекстЗапросаСтруктура);	
		КонецЕсли;
		
		Маршрут = Маршрутизатор.НайтиМаршрут(КонтекстЗапросаСтруктура);

		Если Маршрут = Неопределено Тогда
			Контекст.Ответ.КодСостояния = 404;
			Возврат;
		КонецЕсли;

		КонтекстЗапросаСтруктура.Вставить("Маршрут", Маршрут);

		ПрерватьОбработку = Ложь;
		КонтекстЗапроса = КонтекстЗапросаСтруктура;

		ВызватьМетодПерехватчиков(ОбъектыПерехватчиков, "ПередВыполнениемПредставления", КонтекстЗапроса, ПрерватьОбработку);

		Если НЕ ПрерватьОбработку Тогда
			Маршрутизатор.ПеренаправитьВыполнение(КонтекстЗапроса);
		Иначе
			Если СокрЛП(КонтекстЗапроса.АдресПеренаправления) <> "" Тогда
				Контекст.Ответ.КодСостояния = 303;
				Контекст.Ответ.Заголовки.Добавить("Location", КонтекстЗапроса.АдресПеренаправления);
				Возврат;
			КонецЕсли;	
		КонецЕсли;
		
		ВызватьМетодПерехватчиков(ОбъектыПерехватчиков, "ПослеВыполненияПредставления", КонтекстЗапроса, ПрерватьОбработку);
		
	Исключение
		
		ПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		СтруктураОтвета = Новый Структура("massage", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		Лог.Ошибка("Ошибка при выполнении обработчика соединения: " + ПредставлениеОшибки);
		
		Если Настройки.Получить("Приложение.РежимРазработки") Тогда
			СтруктураОтвета.Вставить("full_error", ПредставлениеОшибки);
		КонецЕсли;
		
		ТестОшибки = Сериализация.СериализоватьJSON(СтруктураОтвета);
		Контекст.Ответ.КодСостояния = 500;

		Если ЗапросОтБраузера Тогда
			Контекст.Ответ.ТипКонтента = ВебСерверСлужебное.ОпределитьТипСодержимого("html");
			КонтекстОшибки = Новый Структура("КодОшибки", Контекст.Ответ.КодСостояния);
			КонтекстОшибки.Вставить("ОписаниеКодаОшибки", ВебСерверСлужебное.ПолучитьОписаниеКодаHTTP(Контекст.Ответ.КодСостояния));
			КонтекстОшибки.Вставить("ТекстОшибки", ТестОшибки);
			Шаблонизатор = Новый Шаблонизатор(Неопределено, "OneCore.Шаблоны.ШаблонОшибки");
			СтраницаОшибки = Шаблонизатор.Сформировать(Новый Структура("Данные",  КонтекстОшибки));
			Контекст.Ответ.Записать(СтраницаОшибки);
		Иначе
			Контекст.Ответ.ТипКонтента = ВебСерверСлужебное.ОпределитьТипСодержимого("json");
			СтраницаОшибки = ТестОшибки;
			Контекст.Ответ.ЗаписатьКакJSON(СтраницаОшибки);
		КонецЕсли;		
		
	КонецПопытки;
	
КонецПроцедуры

Процедура ВызватьМетодПерехватчиков(ОбъектыПерехватчиков, ИмяМетода, Контекст, ПрерватьОбработку)
	
	МассивПараметровВызова = Новый Массив();
	МассивПараметровВызова.Добавить(Контекст);
	МассивПараметровВызова.Добавить(Истина);
	
	Для Каждого ОбъектПерехватчика Из ОбъектыПерехватчиков Цикл
		
		Если МассивПараметровВызова[1] Тогда
			Если Рефлексия.МетодСуществует(ОбъектПерехватчика, ИмяМетода) Тогда
				Попытка
					Рефлексия.ВызватьМетод(ОбъектПерехватчика, ИмяМетода, МассивПараметровВызова);
					ПрерватьОбработку = НЕ МассивПараметровВызова[1];
				Исключение
					Лог.Предупреждение(СтрШаблон("Метод ""%1"" объекта перехватчика ""%2"" не выполнен, по причине: %3",
					ИмяМетода, Строка(ОбъектПерехватчика), ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())));
				КонецПопытки;
			КонецЕсли;
		Иначе
			ПрерватьОбработку = Истина;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ЗапросОтБраузера(Заголовки)
    
	Попытка
		
		UserAgent = Заголовки["User-Agent"];

		Если НЕ ЗначениеЗаполнено(UserAgent) Тогда
			Возврат Ложь;
		КонецЕсли;
		
		Возврат СтрНайти(UserAgent, "Mozilla") > 0 
			   ИЛИ СтрНайти(UserAgent, "Chrome") > 0
			   ИЛИ СтрНайти(UserAgent, "Safari") > 0
			   ИЛИ СтрНайти(UserAgent, "Firefox") > 0
			   ИЛИ СтрНайти(UserAgent, "Edge") > 0
			   ИЛИ СтрНайти(UserAgent, "Opera") > 0;

	Исключение
		Лог.Ошибка("Не удалось опеределить пренадлежность запроса к браузеру");
		Возврат Ложь;
	КонецПопытки;

КонецФункции
