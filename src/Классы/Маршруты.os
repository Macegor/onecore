
Перем СписокМаршрутов;
Перем Компонент;

Процедура ПриСозданииОбъекта(_Компонент = Неопределено)

	Компонент = _Компонент;

	СписокМаршрутов = Новый ТаблицаЗначений();
	СписокМаршрутов.Колонки.Добавить("Адрес", Новый ОписаниеТипов("Строка"));
	СписокМаршрутов.Колонки.Добавить("КлючОбъекта", Новый ОписаниеТипов("Строка"));
	СписокМаршрутов.Колонки.Добавить("Тип", Новый ОписаниеТипов("Строка"));
	СписокМаршрутов.Колонки.Добавить("Статический", Новый ОписаниеТипов("Булево"));
	СписокМаршрутов.Колонки.Добавить("КоличествоЧастейМаршрута", Новый ОписаниеТипов("Число"));
	СписокМаршрутов.Колонки.Добавить("СодержитПараметры", Новый ОписаниеТипов("Булево"));

КонецПроцедуры

Процедура Добавить(Адрес, КлючОбъекта, Статический = Ложь) Экспорт
	
	МенеджерОбъектов = Приложение.МенеджерОбъектов();

	Если Компонент <> Неопределено И НЕ Статический Тогда
		КлючОбъекта = СтрШаблон("%1.%2.%3", Компонент.Имя(), "Представления", КлючОбъекта);
	КонецЕсли;

	Если Статический Тогда
		Тип = Тип("Файл");
	Иначе
		Тип = МенеджерОбъектов.ТипПоКлючу(КлючОбъекта);
	КонецЕсли;

	Если Тип = Неопределено Тогда
		Лог.Предупреждение(СтрШаблон("Не найден обработчик маршрута %1 по ключу %2, маршрут не добавлен", Адрес, КлючОбъекта));
		Возврат;
	КонецЕсли;

	Если НЕ АдресСвободен(Адрес) Тогда
		Лог.Предупреждение(СтрШаблон("Добавляемый адрес %1 занят другим обработчиком или файлом, маршрут не добавлен", Адрес));
		Возврат;
	КонецЕсли;

	НоваяСтрока = СписокМаршрутов.Добавить();
	НоваяСтрока.Адрес = Адрес;
	НоваяСтрока.КлючОбъекта = КлючОбъекта;
	НоваяСтрока.Тип = Тип;
	НоваяСтрока.Статический = Статический;
	НоваяСтрока.КоличествоЧастейМаршрута = СтрРазделить(Адрес, "/", Ложь).Количество();
	НоваяСтрока.СодержитПараметры = СтрНайти(Адрес, "<") > 0;

	Если Компонент <> Неопределено Тогда
		ШаблонТекста = ?(Статический, "Добавлен маршрут %1, путь статического файла: %2", "Добавлен маршрут %1, ключ объекта обработчика: %2");
		Лог.Отладка(СтрШаблон(ШаблонТекста, Адрес, КлючОбъекта));
	КонецЕсли;
	
КонецПроцедуры

Функция СписокМаршрутов() Экспорт
	Возврат СписокМаршрутов;
КонецФункции

Функция НайтиМаршрут(Адрес) Экспорт
	
	// Разбиваем адрес на части
	ЧастиМаршрута = СтрРазделить(Адрес, "/", Ложь);
	КоличествоЧастейМаршрута = ЧастиМаршрута.Количество();

	// Ищем маршруты с таким же количеством частей
	НайденныеМаршруты = СписокМаршрутов.НайтиСтроки(Новый Структура("КоличествоЧастейМаршрута", КоличествоЧастейМаршрута));
	
	Если НЕ НайденныеМаршруты.Количество() Тогда
		Возврат Неопределено;
	КонецЕсли;

	// Для каждого найденного маршрута проверяем совпадение частей
	Для Каждого Маршрут Из НайденныеМаршруты Цикл
		ЧастиНайденногоМаршрута = СтрРазделить(Маршрут.Адрес, "/", Ложь);
		СовпаденийЧастей = 0;
		
		Для Индекс = 0 По КоличествоЧастейМаршрута - 1 Цикл
			ЧастьТекущегоМаршрута = ЧастиМаршрута[Индекс];
			ЧастьНайденногоМаршрута = ЧастиНайденногоМаршрута[Индекс];
			
			Если ЧастьТекущегоМаршрута = ЧастьНайденногоМаршрута Тогда
				СовпаденийЧастей = СовпаденийЧастей + 1;
				Продолжить;
			КонецЕсли;
			
			// Проверяем параметризованные части
			Если СтрНачинаетсяС(ЧастьНайденногоМаршрута, "<") Тогда
				ДанныеЧасти = ДанныеЧастиМаршрутаПараметром(ЧастьНайденногоМаршрута);
				
				Если ДанныеЧасти = Неопределено Тогда
					Продолжить;
				КонецЕсли;
				
				// Проверяем соответствие типа параметра
				Если ДанныеЧасти.Тип = Тип("Число") Тогда
					Попытка
						ЗначениеЧисло = Число(ЧастьТекущегоМаршрута);
						Если ЗначениеЧисло <> 0 Тогда
							СовпаденийЧастей = СовпаденийЧастей + 1;
						КонецЕсли;
					Исключение
						Продолжить;
					КонецПопытки;
				ИначеЕсли ДанныеЧасти.Тип = Тип("Строка") Тогда
					СовпаденийЧастей = СовпаденийЧастей + 1;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		// Если все части совпали - возвращаем найденный маршрут
		Если СовпаденийЧастей = КоличествоЧастейМаршрута Тогда
			Возврат Маршрут;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция ДанныеЧастиМаршрутаПараметром(Знач ЧастьМаршрута) Экспорт
	
	Если НЕ СтрНайти(ЧастьМаршрута, ":") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ЧастьМаршрута = СтрЗаменить(СтрЗаменить(ЧастьМаршрута, "<", ""), ">", "");
	МассивРазделения = СтрРазделить(ЧастьМаршрута, ":", Ложь);
	
	Попытка
		Возврат Новый Структура("Тип, ИмяПараметра", Тип(МассивРазделения[0]), МассивРазделения[1]);
	Исключение
		Лог.Ошибка(СтрШаблон("В части %1 маршрута ошибка: %2", ЧастьМаршрута, ОписаниеОшибки()));
		Возврат Неопределено;
	КонецПопытки;

КонецФункции
Функция АдресСвободен(Адрес)
	
	НайденныеСтроки = СписокМаршрутов.НайтиСтроки(Новый Структура("Адрес", Адрес));
	Возврат НЕ НайденныеСтроки.Количество();

КонецФункции