
Перем Имя;
Перем Компонент;
Перем АдресМаршрута;
Перем КлючОбъекта;
Перем Тип;
Перем Статический;
Перем КоличествоЧастейМаршрута;
Перем СодержитПараметры;
Перем Свойства;
Перем ПользовательскиеОбработчики;

Процедура ПриСозданииОбъекта(Адрес, Ключ, ПарКомпонент = Неопределено)

	АдресМаршрута = Адрес;
	КлючОбъекта = Ключ;
	Статический = Ложь;
	Свойства = Новый Структура();
	ПользовательскиеОбработчики = Новый Структура();
	Компонент = ПарКомпонент;

КонецПроцедуры

Функция Адрес() Экспорт
	Возврат АдресМаршрута;
КонецФункции

Функция КлючОбъекта() Экспорт
	Возврат КлючОбъекта;
КонецФункции

Функция Свойства() Экспорт
	Возврат Свойства;
КонецФункции

Функция ПользовательскиеОбработчики() Экспорт
	Возврат ПользовательскиеОбработчики;
КонецФункции

Функция Имя(Значение = Неопределено) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат Имя;
	КонецЕсли;

	Если ТипЗнч(Значение) <> Тип("Строка") Тогда
		ВызватьИсключение "Ожидается тип Строка";
	КонецЕсли;

	Имя = СтрШаблон("%1.%2", Компонент.Имя(), Значение);
	Возврат ЭтотОбъект;

КонецФункции

Функция Компонент() Экспорт
	
	Возврат Компонент;

КонецФункции

Функция Статический(Значение = Неопределено) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат Статический;
	КонецЕсли;

	Если ТипЗнч(Значение) <> Тип("Булево") Тогда
		ВызватьИсключение "Ожидается тип Булево";
	КонецЕсли;

	Статический = Значение;
	Возврат ЭтотОбъект;

КонецФункции

Функция ТипОбъекта(Значение = Неопределено) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат Тип;
	КонецЕсли;

	Если ТипЗнч(Значение) <> Тип("Тип") Тогда
		ВызватьИсключение "Ожидается тип Тип";
	КонецЕсли;

	Тип = Значение;
	Возврат ЭтотОбъект;

КонецФункции

Функция КоличествоЧастейМаршрута(Значение = Неопределено) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат КоличествоЧастейМаршрута;
	КонецЕсли;

	Если ТипЗнч(Значение) <> Тип("Число") Тогда
		ВызватьИсключение "Ожидается тип Число";
	КонецЕсли;

	КоличествоЧастейМаршрута = Значение;
	Возврат ЭтотОбъект;

КонецФункции

Функция СодержитПараметры(Значение = Неопределено) Экспорт
	
	Если Значение = Неопределено Тогда
		Возврат СодержитПараметры;
	КонецЕсли;

	Если ТипЗнч(Значение) <> Тип("Булево") Тогда
		ВызватьИсключение "Ожидается тип Булево";
	КонецЕсли;

	СодержитПараметры = Значение;
	Возврат ЭтотОбъект;

КонецФункции

Функция ДобавитьСвойство(Ключ, Значение) Экспорт

	Свойства.Вставить(Ключ, Значение);
	Возврат ЭтотОбъект;

КонецФункции

Функция Обработчик(Метод, ИмяПроцедуры) Экспорт
	ПользовательскиеОбработчики.Вставить(Метод, ИмяПроцедуры);
	Возврат ЭтотОбъект;
КонецФункции