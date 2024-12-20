
Перем Имя;
Перем Поля;

Процедура ПриСозданииОбъекта(ИмяТаблицы)
	
	Если Служебное.СоответствуетCamelCase(Имя, Ложь) Тогда
		ВызватьИсключение "Имя таблицы должно быть латинское и соответствовать CamelCase нотации";
	КонецЕсли;

	Имя = ИмяТаблицы;

	Поля = Новый ТаблицаЗначений();
	Поля.Колонки.Добавить("Имя", Тип("Строка"));
	Поля.Колонки.Добавить("Тип", Тип("Тип"));
	Поля.Колонки.Добавить("ПараметрыТипа", Тип("Структура"));

КонецПроцедуры

Процедура ДобавитьПоле(Знач Имя, Знач Тип, Знач ПараметрыТипа) Экспорт
	
	НовоеПоле = Поля.Добавить();
	НовоеПоле.Имя = Имя;
	НовоеПоле.Тип = Тип;
	НовоеПоле.ПараметрыТипа = ПараметрыТипа;

КонецПроцедуры