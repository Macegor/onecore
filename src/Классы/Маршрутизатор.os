
Перем Маршруты;

Процедура ПриСозданииОбъекта()
	
	Маршруты = Новый Маршруты();
	СформироватьМаршруты();

КонецПроцедуры

Процедура СформироватьМаршруты()

	ПроцедураФормированияМаршрутов = "ПриФормированииМаршрутов";
	МенеджерКомпонентов = Приложение.МенеджерКомпонентов();
	Компоненты = МенеджерКомпонентов.Компоненты();

	Для каждого Компонент Из Компоненты Цикл
		
		МодульКомпонента = Компонент.МодульКомпонента();
		ИмяКомпонента = Компонент.Имя();

		Лог.Отладка("Формирование маршрутов компонента " + ИмяКомпонента);

		Если НЕ Рефлексия.МетодСуществует(МодульКомпонента, ПроцедураФормированияМаршрутов) Тогда
			Лог.Предупреждение("Отсутствует процедура формирования маршрутов");
			Продолжить;
		КонецЕсли;

		МаршрутыКомпонента = Новый Маршруты(Компонент);

		МассивПараметров = Новый Массив();
		МассивПараметров.Добавить(МаршрутыКомпонента);

		Рефлексия.ВызватьМетод(МодульКомпонента, ПроцедураФормированияМаршрутов, МассивПараметров);

		Для каждого ДанныеМаршрута Из МаршрутыКомпонента.СписокМаршрутов() Цикл
			Маршруты.Добавить(ДанныеМаршрута.Адрес, ДанныеМаршрута.КлючОбъекта);
		КонецЦикла;	

		ОсвободитьОбъект(МаршрутыКомпонента);

	КонецЦикла;

КонецПроцедуры

Функция ПеренаправитьВыполнение(Запрос) Экспорт
	
	Ответ = Новый ВебОтвет(Запрос);
	Ответ.УстановитьКодСостояния(200);

	ТипЗапроса = Запрос.ТипЗапроса();

	Попытка

		Адрес = Запрос.Адрес();
		ДанныеМаршрута = Маршруты.НайтиМаршрут(Адрес);

		Если ДанныеМаршрута = Неопределено Тогда
			Ответ.УстановитьКодСостояния(404);
			Возврат Ответ;
		КонецЕсли;

		Если ДанныеМаршрута.Статический Тогда
			Возврат Ответ;
		КонецЕсли;

		МенеджерОбъектов = Приложение.МенеджерОбъектов();

		ЗначенияСвойствОбъекта = Новый Структура("Запрос, Ответ, Контекст", Запрос, Ответ, Неопределено);
		ИсполняемыйОбъект = МенеджерОбъектов.СоздатьОбъект(ДанныеМаршрута.КлючОбъекта, Неопределено, ЗначенияСвойствОбъекта);
	
		МассивПараметровВызова = Новый Массив();

		Если ДанныеМаршрута.СодержитПараметры Тогда
			
			ЧастиМаршрутаЗапроса = СтрРазделить(Адрес, "/", Ложь);
			ЧастиНайденногоМаршрута = СтрРазделить(ДанныеМаршрута.Адрес, "/", Ложь);
			СоответствиеЧастей = Новый Соответствие();

			Для Индекс = 0 По ЧастиМаршрутаЗапроса.Количество() - 1 Цикл
				СоответствиеЧастей.Вставить(ЧастиНайденногоМаршрута[Индекс], ЧастиМаршрутаЗапроса[Индекс]);
			КонецЦикла;

			Для каждого КлючЗначение Из СоответствиеЧастей Цикл

				ДанныеПараметра = Маршруты.ДанныеЧастиМаршрутаПараметром(КлючЗначение.Ключ);

				Если ДанныеПараметра <> Неопределено Тогда
					МассивПараметровВызова.Добавить(КлючЗначение.Значение);
				КонецЕсли;

			КонецЦикла;

		КонецЕсли;

		Если Рефлексия.МетодСуществует(ИсполняемыйОбъект, ТипЗапроса) Тогда
			Рефлексия.ВызватьМетод(ИсполняемыйОбъект, ТипЗапроса, МассивПараметровВызова);
		Иначе
			Ответ.УстановитьКодСостояния(405);
			Возврат Ответ;			
		КонецЕсли;

		// TODO: Доделать обработку маршрута до передачи в исполняемый объект

	Исключение

		СтруктураОтвета = Новый Структура("massage", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));

		Если Настройки.Получить("Приложение.РежимРазработки") Тогда
			СтруктураОтвета.Вставить("full_error", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецЕсли;
		
		ТестОшибки = Сериализация.СериализоватьJSON(СтруктураОтвета);		
		Ответ.УстановитьТипСодержимого("json");
		Ответ.УстановитьТелоКакСтроку(ТестОшибки, КодировкаТекста.UTF8);
		Ответ.УстановитьКодСостояния(500);

	КонецПопытки;

	Возврат Ответ;

КонецФункции