
#Использовать strings

Перем ТекущиеСеансы;
Перем Соединения;

Процедура ПриСозданииОбъекта()
	
	ТекущиеСеансы = Новый ТаблицаЗначений();
	ТекущиеСеансы.Колонки.Добавить("Идентификатор");
	ТекущиеСеансы.Колонки.Добавить("Сеанс");

	Соединения = Новый Соответствие();

КонецПроцедуры

Функция СоздатьСеанс() Экспорт
	
	Сеанс = Новый Сеанс();
	Идентификатор = Сеанс.ПолучитьИдентификатор();

	СтрокаСеанса = ТекущиеСеансы.Добавить();
	СтрокаСеанса.Идентификатор = Идентификатор;
	СтрокаСеанса.Сеанс = Сеанс;

	Возврат Сеанс;

КонецФункции

Функция ОпределитьСеанс(Запрос, Ответ) Экспорт

	Куки = ПолучитьКуки(Запрос);
	Сеанс = Неопределено;

	Если Куки <> Неопределено Тогда
		ИдентификаторСеанса = Куки["session_id"];
		Сеанс = НайтиСеанс(ИдентификаторСеанса);	
	КонецЕсли;

	Если Сеанс = Неопределено Тогда
		Сеанс = СоздатьСеанс();
		ДобавитьКуку(Ответ, "session_id", Сеанс.ПолучитьИдентификатор(), Истина, Истина, Сеанс.ПолучитьВремяЖизни());
	КонецЕсли;

	ФоновоеЗадание = ФоновыеЗадания.ПолучитьТекущее();
	Соединения.Вставить(Строка(ФоновоеЗадание.УникальныйИдентификатор), Сеанс);

	Возврат Сеанс;

КонецФункции

Функция НайтиСеансПоИдентификаторуЗадания(ИдентификаторЗадания) Экспорт
	Возврат Соединения[ИдентификаторЗадания];
КонецФункции

Процедура ОчиститьСоединение(ИдентификаторЗадания) Экспорт
	
	Соединения.Удалить(ИдентификаторЗадания);

КонецПроцедуры

Функция НайтиСеанс(Идентификатор)
	
	НайденныеСтроки = ТекущиеСеансы.НайтиСтроки(Новый Структура("Идентификатор", Идентификатор));
	Возврат ?(НайденныеСтроки.Количество(), НайденныеСтроки[0].Сеанс, Неопределено);

КонецФункции

Процедура ДобавитьКуку(Ответ, Ключ, Значение, Защищена = Истина, ТолькоЗапросы = Ложь, ВремяЖизни = Неопределено)
	
	Ключ = Строка(Ключ);
	Значение = Строка(Значение);
	Значение = ?(ВремяЖизни = Неопределено, Значение, Значение + "; Max-Age=" + Формат(ВремяЖизни, "ЧГ=0"));
	Значение = ?(Защищена, Значение + "; SameSite=Strict", Значение);
	Значение = ?(ТолькоЗапросы, Значение + "; HttpOnly", Значение);

	Ответ.ДобавитьЗаголовок("Set-Cookie", Ключ + "=" + Значение);

КонецПроцедуры

Функция ПолучитьКуки(Запрос) Экспорт
	
	ЗаголовкиЗапроса = Запрос.Заголовки();
	Куки = Новый Соответствие();

	КукиСтрокой = ЗаголовкиЗапроса["Cookie"];

	Если Не ЗначениеЗаполнено(КукиСтрокой) Тогда
		Возврат Неопределено;
	КонецЕсли;

	Массив = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(КукиСтрокой, ";", Истина, Истина);

	Для каждого Элемент Из Массив Цикл
		КлючЗначение = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(Элемент, "=", Истина, Истина);
		Куки.Вставить(КлючЗначение[0], КлючЗначение[1]);
	КонецЦикла;

	Возврат Куки;

КонецФункции
