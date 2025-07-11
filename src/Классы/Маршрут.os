Перем Коллекция;
Перем РодительскийМаршрут;
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

Процедура ПриСозданииОбъекта(ОбъектКоллекции, Адрес, Ключ, ПарКомпонент = Неопределено)
	
	АдресМаршрута = Адрес;
	КлючОбъекта = Ключ;
	Статический = Ложь;
	Свойства = Новый Структура();
	ПользовательскиеОбработчики = Новый Структура();
	Компонент = ПарКомпонент;
	Коллекция = ОбъектКоллекции;
	
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
	
	Если РодительскийМаршрут = Неопределено Тогда
		Имя = СтрШаблон("%1.%2", Компонент.Имя(), Значение);
	Иначе
		Имя = СтрШаблон("%1.%2", РодительскийМаршрут.Имя(), Значение);
	КонецЕсли;
	
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

Функция Дочерний(Адрес, Ключ = Неопределено) Экспорт
	
	ДочернийМаршрут = Неопределено;
	
	КлючДочернего = ?(Ключ = Неопределено, КлючОбъекта, Ключ);
	АдресДочернего = СтрШаблон("%1/%2", АдресМаршрута, ?(СтрНачинаетсяС(Адрес, "/"), Прав(Адрес, СтрДлина(Адрес) - 1), Адрес));
	
	ДочернийМаршрут = Коллекция.Добавить(АдресДочернего, КлючДочернего);
	
	Если ДочернийМаршрут <> Неопределено Тогда
		СвойстваПодчиненногоМаршрута = Коллекции.СкопироватьСтруктуру(Свойства);
		Рефлексия.УстановитьСвойство(ДочернийМаршрут, "РодительскийМаршрут", ЭтотОбъект);
		Рефлексия.УстановитьСвойство(ДочернийМаршрут, "Свойства", СвойстваПодчиненногоМаршрута);
	КонецЕсли;
	
	Если КлючДочернего <> КлючОбъекта Тогда
		ДочерниеИзПредставления(КлючОбъекта);	
	КонецЕсли;

	Возврат ДочернийМаршрут;
	
КонецФункции

Функция ДочерниеИзПредставления(Знач Ключ = "") Экспорт
	
	Если Ключ = "" Тогда
		Ключ = КлючОбъекта;
	КонецЕсли;

	Если НЕ СтрНайти(Ключ, ".Представления.") Тогда
		КлючДочернегоОбъекта = СтрШаблон("%1.%2.%3", Компонент.Имя(), "Представления", Ключ);
	Иначе
		КлючДочернегоОбъекта = Ключ;
	КонецЕсли;
		
	МенеджерОбъектов = Приложение.МенеджерОбъектов();
	ТипОбъекта = МенеджерОбъектов.ТипПоКлючу(КлючДочернегоОбъекта);
	ОбъектПредставления = Новый(ТипОбъекта);
	МассивАдресов = Новый Массив();

	МассивМетодов = Новый Массив();
	МассивМетодов.Добавить("GET");
	МассивМетодов.Добавить("HEAD");
	МассивМетодов.Добавить("POST");
	МассивМетодов.Добавить("PUT");
	МассивМетодов.Добавить("DELETE");
	МассивМетодов.Добавить("CONNECT");
	МассивМетодов.Добавить("OPTIONS");
	МассивМетодов.Добавить("TRACE");
	МассивМетодов.Добавить("PATCH");
	
	Для Каждого ИмяМетода Из МассивМетодов Цикл
		
		ТаблицаМетодов = Рефлексия.ПолучитьТаблицуМетодов(ОбъектПредставления, ИмяМетода);
		
		Для Каждого ДанныеМетодаМаршрута Из ТаблицаМетодов Цикл
			
			АннотацииМетода = Рефлексия.АннотацииМетода(ОбъектПредставления, ДанныеМетодаМаршрута.Имя);
			ПараметрыАннотации = Неопределено;
			Адрес = Неопределено;
			ИмяМаршрута = Неопределено;
			
			Если НЕ АннотацииМетода.Свойство(ИмяМетода, ПараметрыАннотации) Тогда
				Продолжить;
			КонецЕсли;
			
			Если ТипЗнч(ПараметрыАннотации) <> Тип("Структура") Тогда
				Продолжить;
			КонецЕсли;
			
			Если НЕ ПараметрыАннотации.Свойство("Адрес", Адрес) Тогда
				Продолжить;
			КонецЕсли;
			
			Если МассивАдресов.Найти(Адрес) <> Неопределено Тогда
				Продолжить;
			КонецЕсли;

			МассивАдресов.Добавить(Адрес);
			ДочернийМаршрут = Дочерний(ПараметрыАннотации.Адрес, КлючДочернегоОбъекта);
			
			Если ДочернийМаршрут = Неопределено Тогда
				Продолжить;
			КонецЕсли;

			ДочернийМаршрут.Обработчик(ИмяМетода, ДанныеМетодаМаршрута.Имя);

			Если ПараметрыАннотации.Свойство("Имя", ИмяМаршрута) Тогда
				ДочернийМаршрут.Имя(ИмяМаршрута);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ЭтотОбъект;

КонецФункции