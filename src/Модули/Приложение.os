// #Использовать entity

Перем МенеджерОбъектов;
Перем МенеджерКомпонентов;
Перем МенеджерСеансов;
Перем Коннекторы1С;
// Перем МенеджерБазыДанных;

Процедура Запустить() Экспорт
	
	// Инициализация настроек приложения
	НастройкиПоУмолчанию = ЗаполнитьСтруктуруНастроекПоУмолчанию();
	Настройки.Инициализировать(НастройкиПоУмолчанию);
	
	// Инициализация логирования
	РежимРазработки = Настройки.Получить("Приложение.РежимРазработки");
	УровеньВыводаЛогов = Настройки.Получить("Приложение.УровеньВыводаЛогов");
	
	Если РежимРазработки Тогда
		УровеньВыводаЛогов = "Отладка";
	КонецЕсли;
	
	Лог.Инициализировать(УровеньВыводаЛогов);

	// МенеджерБазыДанных.Инициализировать();
	
	Порт = Настройки.Получить("Приложение.ПортПрослушивания");
	
	СервисВебСервера = Новый СервисВебСервер(Порт);
	СервисВебСервера.Запустить(Истина);
	
КонецПроцедуры

// Процедура ИспользоватьБазуДанных() Экспорт
// 	МенеджерБазыДанных = Новый МенеджерБазыДанных();
// КонецПроцедуры

Процедура ИспользоватьКоннектор1С(Имя) Экспорт
	Коннекторы1С.Добавить(Имя);
КонецПроцедуры

Функция Коннекторы1С() Экспорт
	Возврат Коннекторы1С;
КонецФункции

Функция МенеджерОбъектов() Экспорт
	Возврат МенеджерОбъектов;
КонецФункции

Функция МенеджерКомпонентов() Экспорт
	Возврат МенеджерКомпонентов;
КонецФункции

Функция МенеджерСеансов() Экспорт
	Возврат МенеджерСеансов;
КонецФункции

Функция ЗаполнитьСтруктуруНастроекПоУмолчанию()
	
	Структура = Новый Структура();
	
	Структура.Вставить("ПортПрослушивания", 5555);
	Структура.Вставить("РежимРазработки", Истина);
	Структура.Вставить("УровеньВыводаЛогов", "Информация");

	Если Коннекторы1С.Количество() Тогда

		МассивНастроекБаз1С = Новый Структура();
		СтруктураНастроекБазы1С = Новый Структура("АдресСервера, ИмяПубликации, ЗащищенноеСоединение, Пользователь, Пароль", "", "", Ложь, "", "");

		Для каждого ИмяБазы1С Из Коннекторы1С Цикл
			МассивНастроекБаз1С.Вставить(ИмяБазы1С, СтруктураНастроекБазы1С);
		КонецЦикла;

		Структура.Вставить("Коннекторы1С", МассивНастроекБаз1С);

	КонецЕсли;

	// Если МенеджерБазыДанных <> Неопределено Тогда
	// 	Структура.Вставить("БазаДанных", Новый Структура("Адрес, ИмяБазы, Пользователь, Пароль, Порт"));
	// КонецЕсли;
	
	Возврат Структура;
	
КонецФункции

МенеджерОбъектов = Новый МенеджерОбъектов();
МенеджерКомпонентов = Новый МенеджерКомпонентов();
МенеджерСеансов = Новый МенеджерСеансов();
Коннекторы1С = Новый Массив();

Лог.Инициализировать();
Лог.Отладка("Настройки проинициализированы");