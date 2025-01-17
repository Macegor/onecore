// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:UnusedLocalMethod-off
#Использовать strings
#Использовать fs

Перем КодВыполнения;
Перем ЧастиШаблона;
Перем РамкиБлоков;
Перем СоответствияРамокБлоков;
Перем ОбъектПредставления;
Перем Контекст;
Перем РасширяемыйШаблон;

Перем ТекстШаблона Экспорт;

Процедура ПриСозданииОбъекта(Представление, КонтекстФормирования)
	
	ОбъектПредставления = Представление;
	Контекст = КонтекстФормирования;
	
	РамкиБлоков = Новый Структура();
	РамкиБлоков.Вставить("НачалоВыражения", МассивИзДвухСимволов("{", "{"));
	РамкиБлоков.Вставить("ОкончаниеВыражения", МассивИзДвухСимволов("}", "}"));
	РамкиБлоков.Вставить("НачалоОператора", МассивИзДвухСимволов("{", "%"));
	РамкиБлоков.Вставить("ОкончаниеОператора", МассивИзДвухСимволов("%", "}"));
	
	СоответствияРамокБлоков = Новый Соответствие;
	СоответствияРамокБлоков.Вставить(СтрСоединить(РамкиБлоков.НачалоВыражения, ""), РамкиБлоков.ОкончаниеВыражения);
	СоответствияРамокБлоков.Вставить(СтрСоединить(РамкиБлоков.НачалоОператора, ""), РамкиБлоков.ОкончаниеОператора);
	
КонецПроцедуры

Процедура ИнициализацияПеременных()
	
	КодВыполнения = Новый Массив();
	ЧастиШаблона = Новый Соответствие();
	
КонецПроцедуры

Функция Сформировать(КлючШаблона) Экспорт
	
	ТекстРасширяемогоШаблона = Неопределено;
	БлокиШаблона = Новый Массив();
	
	ИнициализацияПеременных();
	ТекстШаблонаПоПути(КлючШаблона);
	
	БлокПоиска = Новый Массив(2);
	ТекущийПоток = Новый Массив;
	
	ИскомоеОкочание = Неопределено;
	
	Для Сч = 1 По СтрДлина(ТекстШаблона) Цикл
		ТекущийСимвол = Сред(ТекстШаблона, Сч, 1);
		ДобавитьВМассивСоСмещением(БлокПоиска, ТекущийСимвол);
		
		Если МассивыРавны(БлокПоиска, РамкиБлоков.НачалоВыражения)
			ИЛИ МассивыРавны(БлокПоиска, РамкиБлоков.НачалоОператора) Тогда
			Ид = ДобавитьЧастьШаблона(ТекущийПоток);
			ТекущийПоток = Новый Массив;
			ИскомоеОкочание = ПолучитьЗакрывающийТег(БлокПоиска);
			ЧастьКодаВставкаЧастиШаблона(Ид);
			
		ИначеЕсли НЕ ИскомоеОкочание = Неопределено
			И МассивыРавны(БлокПоиска, ИскомоеОкочание) Тогда
			ЧастьКода = СтрокаИзМассива(ТекущийПоток);
			ТекущийПоток = Новый Массив;
			ДобавитьЧастьКодаОтОкочания(ЧастьКода, ИскомоеОкочание);
			ИскомоеОкочание = Неопределено;
			
		Иначе
			ТекущийПоток.Добавить(ТекущийСимвол);
		КонецЕсли;
	КонецЦикла;
	
	Если ТекущийПоток.Количество() > 0 Тогда
		ТекущийПоток.Добавить(" ");
		Ид = ДобавитьЧастьШаблона(ТекущийПоток);
		ЧастьКодаВставкаЧастиШаблона(Ид);
	КонецЕсли;
	
	Результат = Новый Массив;
	
	ЗаполнитьМассивКодом(Результат);
	
	ТекстОтображения = СтрСоединить(Результат, "");
	
	Если ЗначениеЗаполнено(РасширяемыйШаблон) Тогда
		
		Шаблонизатор = Новый Шаблонизатор(ОбъектПредставления, Контекст);
		ТекстРасширяемогоШаблона = Шаблонизатор.Сформировать(РасширяемыйШаблон);
		БлокиШаблона = НайтиВсеБлокиВШаблоне(ТекстРасширяемогоШаблона);
		
		Если БлокиШаблона.Количество() Тогда
			
			Для Каждого ИмяБлока Из БлокиШаблона Цикл
				
				Если НЕ СтрНайти(ТекстОтображения, ИмяБлока) Тогда
					Продолжить;
				КонецЕсли;
				
				ТекстБлока = ПолучитьТекстМеждуТегами(ТекстОтображения, ИмяБлока);
				ТекстРасширяемогоШаблона = СтрЗаменить(ТекстРасширяемогоШаблона, Блок(ИмяБлока), ТекстБлока);
				
			КонецЦикла;
			
			ТекстОтображения = ТекстРасширяемогоШаблона;
		Иначе
			ТекстОтображения = УдалитьТегиИзТекста(ТекстОтображения);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ТекстОтображения;
	
КонецФункции

Процедура ЗаполнитьМассивКодом(Результат)
	
	ВесьКод = СтрСоединить(КодВыполнения);
	Выполнить(ВесьКод);
	
КонецПроцедуры

Процедура ДобавитьЧастьКодаОтОкочания(ЧастьКода, Окончание)
	
	Если Окончание = РамкиБлоков.ОкончаниеВыражения Тогда
		КодКДобавлению = СтрШаблон("_Значение = Строка(%1);
				|Результат.Добавить(_Значение);", ЧастьКода);
		КодВыполнения.Добавить(КодКДобавлению + Символы.ПС);
	Иначе
		КодВыполнения.Добавить(ЧастьКода + Символы.ПС);
	КонецЕсли;
	
КонецПроцедуры

Процедура ЧастьКодаВставкаЧастиШаблона(Ид)
	
	Код = СтрШаблон("Результат.Добавить(ЧастиШаблона[""%1""]);", Ид);
	КодВыполнения.Добавить(Код + Символы.ПС);
	
КонецПроцедуры

Функция ДобавитьЧастьШаблона(МассивСимволов)
	
	Строка = СтрокаИзМассива(МассивСимволов);
	Ид = ХешироватьСтроку(Строка);
	
	ЧастиШаблона.Вставить(Ид, Строка);
	
	Возврат Ид;
	
КонецФункции

Функция СтрокаИзМассива(МассивСимволов)
	МассивСимволов.Удалить(МассивСимволов.ВГраница());
	Строка = СтрСоединить(МассивСимволов, "");
	Возврат Строка;
КонецФункции

Функция ХешироватьСтроку(Строка)
	
	Хеширование = Новый ХешированиеДанных(ХешФункция.MD5);
	
	Хеширование.Добавить(Строка);
	
	Возврат Base64Строка(Хеширование.ХешСумма);
	
КонецФункции

Функция МассивИзДвухСимволов(Символ1, Символ2)
	
	Массив = Новый Массив(2);
	Массив[0] = Символ1;
	Массив[1] = Символ2;
	
	Возврат Массив;
	
КонецФункции

Функция ПолучитьЗакрывающийТег(ОткрывающийТег)
	
	Возврат СоответствияРамокБлоков.Получить(СтрСоединить(ОткрывающийТег, ""));
	
КонецФункции

Функция МассивыРавны(Массив1, Массив2) Экспорт
	
	Если НЕ Массив1.Количество() = Массив2.Количество() Тогда
		Возврат Ложь;
	Иначе
		Для сч = 0 По Массив1.ВГраница() Цикл
			Если НЕ Массив1[сч] = Массив2[сч] Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Процедура ДобавитьВМассивСоСмещением(Массив, ДобавляемыйЭлемент) Экспорт
	
	Если Массив.Количество() = 1 Тогда
		Массив[0] = ДобавляемыйЭлемент;
		Возврат;
	ИначеЕсли Массив.Количество() = 0 Тогда
		ВызватьИсключение "Пустой массив для смещения";
	КонецЕсли;
	
	Для сч = 0 По Массив.ВГраница() - 1 Цикл
		Массив[сч] = Массив[сч + 1];
	КонецЦикла;
	
	Массив[Массив.ВГраница()] = ДобавляемыйЭлемент;
	
КонецПроцедуры

Функция Вложить(КлючШаблона, Данные = Неопределено)
	
	КонтекстФормирования = ?(Данные = Неопределено, Контекст, Данные);
	
	ВложенныйШаблон = Новый Шаблонизатор(ОбъектПредставления, КонтекстФормирования);
	Возврат ВложенныйШаблон.Сформировать(КлючШаблона);
	
КонецФункции

Функция Расширить(КлючШаблона)
	
	РасширяемыйШаблон = КлючШаблона;
	
КонецФункции

Функция Блок(ИмяБлока)
	Возврат СтрШаблон("<<%1>>", ИмяБлока);
КонецФункции

Функция Поместить(ИмяБлока)
	Возврат Блок(ИмяБлока);
КонецФункции

Функция КонецПомещения()
	Возврат "<</>>";
КонецФункции

Функция Ресурс(ПутьРесурса)
	
	Если НЕ ЗначениеЗаполнено(ПутьРесурса) Тогда
		Лог.Ошибка("Не верный или пустой путь к ресурсу");
		Возврат "";
	КонецЕсли;
	
	ЧастиПутейРесурса = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(ПутьРесурса, "/", Истина, Истина);
	ПутьКФайлуРесурса = "/";
	МенеджерКомпонентов = Приложение.МенеджерКомпонентов();
	
	ТекущийКомпонент = МенеджерКомпонентов.НайтиПоКлючуОбъекта(ОбъектПредставления);
	ЛатинскоеИмяКомпонента = ТекущийКомпонент.ИмяЛатинское();
	НачинаетсяСИмениКомпонента = Истина;
	
	Если ЧастиПутейРесурса[0] <> ТекущийКомпонент.Имя() Тогда
		
		КомпонентРесурса = МенеджерКомпонентов.НайтиПоКлючуОбъекта(ЧастиПутейРесурса[0]);
		НачинаетсяСИмениКомпонента = Ложь;
		
		Если КомпонентРесурса <> Неопределено Тогда
			ЛатинскоеИмяКомпонента = КомпонентРесурса.ИмяЛатинское();
		Иначе
			НачинаетсяСИмениКомпонента = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если НЕ НачинаетсяСИмениКомпонента Тогда
		ПутьКФайлуРесурса = ПутьКФайлуРесурса + ЛатинскоеИмяКомпонента;
	КонецЕсли;
	
	Для Счетчик = 0 По ЧастиПутейРесурса.Количество() - 1 Цикл
		Если Счетчик = 0 Тогда
			Если НачинаетсяСИмениКомпонента Тогда
				ПутьКФайлуРесурса = ПутьКФайлуРесурса + ЛатинскоеИмяКомпонента;
			Иначе
				ПутьКФайлуРесурса = ПутьКФайлуРесурса + "/" + ЧастиПутейРесурса[Счетчик];
			КонецЕсли;
		Иначе
			ПутьКФайлуРесурса = ПутьКФайлуРесурса + "/" + ЧастиПутейРесурса[Счетчик];
		КонецЕсли;
	КонецЦикла;
	
	Возврат ПутьКФайлуРесурса;
	
КонецФункции

Процедура ТекстШаблонаПоПути(Знач КлючШаблона)
	
	ТекстШаблона = "";
	
	Если НЕ СтрНайти(КлючШаблона, ".Шаблоны.") Тогда
		ИмяКомпонента = Лев(КлючШаблона, СтрНайти(КлючШаблона, ".") - 1);
		Ключ = СтрЗаменить(КлючШаблона, ИмяКомпонента, ИмяКомпонента + ".Шаблоны");
	Иначе
		Ключ = КлючШаблона;
	КонецЕсли;
	
	Если СтрНачинаетсяС(КлючШаблона, "OneCore") Тогда
		Ключ = СтрЗаменить(Ключ, "OneCore.", "");
		ПутьКФайлуШаблона = ОбъединитьПути(Служебное.КаталогБиблиотеки(), "src", "Служебное");
	Иначе
		ПутьКФайлуШаблона = Служебное.КаталогПриложения();
	КонецЕсли;
	
	ЧастиПутейШаблона = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(Ключ, ".", Истина, Истина);
	
	Для Каждого ЧастьПути Из ЧастиПутейШаблона Цикл
		ПутьКФайлуШаблона = ОбъединитьПути(ПутьКФайлуШаблона, ЧастьПути);
	КонецЦикла;
	
	ПутьКФайлуШаблона = ПутьКФайлуШаблона + ".html";
	
	Если НЕ ФС.ФайлСуществует(ПутьКФайлуШаблона) Тогда
		ВызватьИсключение СтрШаблон("Не найден файл шаблона по пути: %1", ПутьКФайлуШаблона);
	КонецЕсли;
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.Прочитать(ПутьКФайлуШаблона);
	ТекстШаблона = ТекстовыйДокумент.ПолучитьТекст();
	
КонецПроцедуры


// Функция извлекает текст между тегами <<параметр>> и <</>>
//
// Параметры:
//   ТекстШаблона - Строка - Текст, в котором производится поиск
//   ИмяПараметра - Строка - Имя параметра для поиска
//
// Возвращаемое значение:
//   Строка - Найденный текст между тегами
//
Функция ПолучитьТекстМеждуТегами(Знач ТекстШаблона, Знач ИмяПараметра)
	
	НачальныйТег = "<<" + ИмяПараметра + ">>";
	КонечныйТег = "<</>>";
	
	ПозицияНачала = СтрНайти(ТекстШаблона, НачальныйТег);
	Если ПозицияНачала = 0 Тогда
		Возврат "";
	КонецЕсли;
	
	ПозицияНачалаТекста = ПозицияНачала + СтрДлина(НачальныйТег);
	ПозицияКонца = СтрНайти(ТекстШаблона, КонечныйТег, , ПозицияНачалаТекста);
	
	Если ПозицияКонца = 0 Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат Сред(ТекстШаблона, ПозицияНачалаТекста, ПозицияКонца - ПозицияНачалаТекста);
	
КонецФункции

// Функция возвращает массив имен всех блоков в шаблоне
//
// Параметры:
//   ТекстШаблона - Строка - Текст шаблона для поиска блоков
//
// Возвращаемое значение:
//   Массив - Массив имен найденных блоков без тегов
//
Функция НайтиВсеБлокиВШаблоне(Знач ТекстШаблона) Экспорт
	
	МассивБлоков = Новый Массив;
	ТекущаяПозиция = 1;
	
	Пока Истина Цикл
		НачалоБлока = СтрНайти(ТекстШаблона, "<<", , ТекущаяПозиция);
		
		Если НачалоБлока = 0 Тогда
			Прервать;
		КонецЕсли;
		
		КонецБлока = СтрНайти(ТекстШаблона, ">>", , НачалоБлока);
		
		Если КонецБлока = 0 Тогда
			Прервать;
		КонецЕсли;
		
		ИмяБлока = Сред(ТекстШаблона, НачалоБлока + 2, КонецБлока - НачалоБлока - 2);
		
		Если ИмяБлока <> "/" Тогда
			МассивБлоков.Добавить(ИмяБлока);
		КонецЕсли;
		
		ТекущаяПозиция = КонецБлока + 2;
	КонецЦикла;
	
	Возврат МассивБлоков;
	
КонецФункции

// Процедура удаляет из текста все теги и их содержимое
//
// Параметры:
//   ТекстШаблона - Строка - Исходный текст для обработки
//
// Возвращаемое значение:
//   Строка - Текст с удаленными тегами
//
Функция УдалитьТегиИзТекста(Знач ТекстШаблона) Экспорт
	
	ОбработанныйТекст = ТекстШаблона;
	ТекущаяПозиция = 1;
	
	Пока Истина Цикл
		НачалоБлока = СтрНайти(ОбработанныйТекст, "<<", , ТекущаяПозиция);
		
		Если НачалоБлока = 0 Тогда
			Прервать;
		КонецЕсли;
		
		КонецБлока = СтрНайти(ОбработанныйТекст, ">>", , НачалоБлока);
		
		Если КонецБлока = 0 Тогда
			Прервать;
		КонецЕсли;
		
		// Удаляем найденный блок
		ОбработанныйТекст = Лев(ОбработанныйТекст, НачалоБлока - 1) +
			Сред(ОбработанныйТекст, КонецБлока + 2);
		
		ТекущаяПозиция = НачалоБлока;
	КонецЦикла;
	
	Возврат ОбработанныйТекст;
	
КонецФункции