#Использовать fs

Перем Маршруты;

Процедура ПриСозданииОбъекта()
	
	Маршруты = Новый Маршруты();
	СформироватьМаршруты();
	
КонецПроцедуры

Процедура СформироватьМаршруты()
	
	ПроцедураФормированияМаршрутов = "ПриФормированииМаршрутов";
	МенеджерКомпонентов = Приложение.МенеджерКомпонентов();
	Компоненты = МенеджерКомпонентов.Компоненты();
	КомпонентКорняСтатическихФайлов = МенеджерКомпонентов.КомпонентКорняСтатическихФайлов();
	КаталогПриложения = Служебное.КаталогПриложения();
	
	Для Каждого Компонент Из Компоненты Цикл
		
		МодульКомпонента = Компонент.МодульКомпонента();
		ИмяКомпонента = Компонент.Имя();
		ПутьКомпонента = ОбъединитьПути(КаталогПриложения, ИмяКомпонента);
		
		Лог.Отладка("Формирование маршрутов компонента " + ИмяКомпонента);
		
		Если НЕ Рефлексия.МетодСуществует(МодульКомпонента, ПроцедураФормированияМаршрутов) Тогда
			Лог.Предупреждение("Отсутствует процедура формирования маршрутов");
			Продолжить;
		КонецЕсли;
		
		МаршрутыКомпонента = Новый Маршруты(Компонент);
		
		МассивПараметров = Новый Массив();
		МассивПараметров.Добавить(МаршрутыКомпонента);
		
		Рефлексия.ВызватьМетод(МодульКомпонента, ПроцедураФормированияМаршрутов, МассивПараметров);
		
		// Автодобавление маршрутов статических файлов
		ПутьКРесурсам = ОбъединитьПути(ПутьКомпонента, "Ресурсы");
		
		СформироватьМаршрутыРесурсов(ПутьКРесурсам, Компонент, МаршрутыКомпонента, КомпонентКорняСтатическихФайлов);
		
		Для Каждого ДанныеМаршрута Из МаршрутыКомпонента.СписокМаршрутов() Цикл
			Маршруты.Добавить(ДанныеМаршрута.Адрес, ДанныеМаршрута.КлючОбъекта, ДанныеМаршрута.Статический);
		КонецЦикла;
		
		ОсвободитьОбъект(МаршрутыКомпонента);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьМаршрутыРесурсов(ПутьКРесурсам, Компонент, МаршрутыКомпонента, КомпонентКорняСтатическихФайлов)
	
	ИмяКомпонента = Компонент.Имя();
	ИмяКомпонентаЛатинское = Компонент.ИмяЛатинское();
	КаталогПриложения = Служебное.КаталогПриложения();
	
	Если НЕ ФС.КаталогСуществует(ПутьКРесурсам) Тогда
		Лог.Отладка(СтрШаблон("В компоненте ""%1"" отсутствует каталог с ресурсам", ИмяКомпонента));
		Возврат;
	КонецЕсли;
	
	ФайлыРесурсов = НайтиФайлы(ПутьКРесурсам, "*.*", Истина);
	
	Для Каждого ФайлРесурса Из ФайлыРесурсов Цикл
		
		ОтносительныйПуть = СтрЗаменить(ФайлРесурса.ПолноеИмя, КаталогПриложения, "");
		ОтносительныйПуть = Прав(ОтносительныйПуть, СтрДлина(ОтносительныйПуть) - 1);
		ПутьБезКомпонента = Прав(ОтносительныйПуть, СтрДлина(ОтносительныйПуть) - СтрДлина(ИмяКомпонента));
		
		Если Компонент = КомпонентКорняСтатическихФайлов Тогда
			ПутьОтКорня = СтрЗаменить(ПутьБезКомпонента, "Ресурсы", "");
			ПутьОтКорня = СтрЗаменить(Прав(ПутьОтКорня, СтрДлина(ПутьОтКорня) - 1), "\", "/");
			МаршрутыКомпонента.Добавить(ПутьОтКорня, ФайлРесурса.ПолноеИмя, Истина);
		КонецЕсли;
		
		ПутьОтКомпонента = СтрЗаменить(СтрЗаменить(ПутьБезКомпонента, "Ресурсы", ИмяКомпонентаЛатинское), "\", "/");
		МаршрутыКомпонента.Добавить(ПутьОтКомпонента, ФайлРесурса.ПолноеИмя, Истина);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПеренаправитьВыполнение(Контекст) Экспорт
	
	Запрос = Контекст.Запрос;
	Ответ = Контекст.Ответ;
	
	Ответ.КодСостояния = 200;
	
	ТипЗапроса = Запрос.Метод;
	
	Адрес = Запрос.Путь;
	ДанныеМаршрута = Маршруты.НайтиМаршрут(Адрес);
	
	Если ДанныеМаршрута = Неопределено Тогда
		Ответ.КодСостояния = 404;
		Возврат;
	КонецЕсли;
	
	Если ДанныеМаршрута.Статический Тогда
		
		ПутьКФайлу = ДанныеМаршрута.КлючОбъекта;
		Файл = Новый Файл(ПутьКФайлу);
		
		Если НЕ Файл.Существует() Тогда
			Ответ.КодСостояния = 404;
		Иначе
			РасширениеБезТочки = Файл.Расширение;
			Ответ.ТипКонтента = ВебСерверСлужебное.ОпределитьТипСодержимого(РасширениеБезТочки);
			Поток = ФайловыеПотоки.ОткрытьДляЧтения(ПутьКФайлу);
			Поток.КопироватьВ(Ответ.Тело);
		КонецЕсли;
		
		Возврат;
		
	КонецЕсли;
	
	МенеджерОбъектов = Приложение.МенеджерОбъектов();
	ЗначенияСвойствОбъекта = Новый Структура("Контекст", Контекст);

	Для каждого КлючЗначение Из Контекст Цикл
		ЗначенияСвойствОбъекта.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
	КонецЦикла;

	ИсполняемыйОбъект = МенеджерОбъектов.СоздатьОбъект(ДанныеМаршрута.КлючОбъекта, Неопределено, ЗначенияСвойствОбъекта);
	
	Если ИсполняемыйОбъект = Неопределено Тогда
		Ответ.КодСостояния = 500;
		СтруктураОтвета = Новый Структура("massage", "Ошибка при создании объекта по ключу: " + ДанныеМаршрута.КлючОбъекта);
		Ответ.Записать(Сериализация.СериализоватьJSON(СтруктураОтвета), КодировкаТекста.UTF8);
		Возврат;
	КонецЕсли;
	
	МассивПараметровВызова = Новый Массив();
	
	Если ДанныеМаршрута.СодержитПараметры Тогда
		
		ЧастиМаршрутаЗапроса = СтрРазделить(Адрес, "/", Ложь);
		ЧастиНайденногоМаршрута = СтрРазделить(ДанныеМаршрута.Адрес, "/", Ложь);
		СоответствиеЧастей = Новый Соответствие();
		
		Для Индекс = 0 По ЧастиМаршрутаЗапроса.Количество() - 1 Цикл
			СоответствиеЧастей.Вставить(ЧастиНайденногоМаршрута[Индекс], ЧастиМаршрутаЗапроса[Индекс]);
		КонецЦикла;
		
		Для Каждого КлючЗначение Из СоответствиеЧастей Цикл
			
			ДанныеПараметра = Маршруты.ДанныеЧастиМаршрутаПараметром(КлючЗначение.Ключ);
			
			Если ДанныеПараметра <> Неопределено Тогда
				МассивПараметровВызова.Добавить(КлючЗначение.Значение);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если НЕ Рефлексия.МетодСуществует(ИсполняемыйОбъект, ТипЗапроса) Тогда
		Ответ.КодСостояния = 405;
		Возврат;
	КонецЕсли;
	
	АннотацииМетода = Рефлексия.АннотацииМетода(ИсполняемыйОбъект, ТипЗапроса);
	
	// Для отправленных форм от браузера штатным образом помещаем входящие данные в контекст
	Если Запрос.ТипКонтента = "application/x-www-form-urlencoded" Тогда
		
		ТелоСтрокой = ВебСерверСлужебное.ТелоКакСтрокаИзЗапроса(Контекст.Запрос);
		ВходящиеПараметры = Сериализация.РазобратьТелоЗапросаAXWWWFU(ТелоСтрокой);
		
		Для Каждого Параметр Из ВходящиеПараметры Цикл
			Если Контекст.Данные.Свойство(Параметр.Ключ) Тогда
				Контекст.Данные[Параметр.Ключ] = Параметр.Значение;
			Иначе
				Контекст.Данные.Вставить(Параметр.Ключ, Параметр.Значение);
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
	Если Рефлексия.МетодСуществует(ИсполняемыйОбъект, "Инициализация") Тогда
		Рефлексия.ВызватьМетод(ИсполняемыйОбъект, "Инициализация");
	КонецЕсли;

	Контекст.Ответ.ТипКонтента = ?(Контекст.ЗапросОтБраузера, "text/html", "application/json");

	Если АннотацииМетода.Свойство("ПараметрыОтвета") Тогда
		Если ТипЗнч(АннотацииМетода.ПараметрыОтвета) = Тип("Структура") Тогда
			АннотацииМетода.ПараметрыОтвета.Свойство("КодОтвета", Контекст.Ответ.КодСостояния);
			АннотацииМетода.ПараметрыОтвета.Свойство("ТипСодержимого", Контекст.Ответ.ТипКонтента);
		КонецЕсли;
	КонецЕсли;
	
	Рефлексия.ВызватьМетод(ИсполняемыйОбъект, ТипЗапроса, МассивПараметровВызова);
	
	// Если не указана кодировка, то добавляем UTF-8
	Если СтрНайти(Ответ.ТипКонтента, "") ИЛИ НЕ СтрНайти(НРег(Строка(Ответ.ТипКонтента)), "charset=") Тогда
		Ответ.ТипКонтента = Ответ.ТипКонтента + "; charset=utf-8";
	КонецЕсли;

	Если СокрЛП(Контекст.АдресПеренаправления) <> "" Тогда
		Контекст.Ответ.КодСостояния = 303;
		Ответ.Заголовки.Добавить("Location", Контекст.АдресПеренаправления);
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Контекст.Ответ.КодСостояния) Тогда
		Контекст.Ответ.КодСостояния = 200;
	КонецЕсли;
	
	Если АннотацииМетода.Свойство("ФормироватьШаблон") Тогда
		Шаблонизатор = Новый Шаблонизатор(ИсполняемыйОбъект, АннотацииМетода.ФормироватьШаблон);
		ТекстОтвета = Шаблонизатор.Сформировать(Контекст);
		Контекст.Ответ.Записать(ТекстОтвета);
	КонецЕсли;
	
КонецПроцедуры
