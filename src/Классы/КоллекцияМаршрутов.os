
Перем МассивКоллекции;

&Обходимое
Процедура ПриСозданииОбъекта()
	МассивКоллекции = Новый Массив();
КонецПроцедуры

Функция ПолучитьИтератор()
    Возврат Новый ИтераторМаршрутов(ЭтотОбъект);
КонецФункции

Функция Количество() Экспорт
    Возврат МассивКоллекции.Количество();
КонецФункции

Функция Получить(Индекс) Экспорт

    Если Индекс <= МассивКоллекции.ВГраница() Тогда
        Возврат МассивКоллекции[Индекс];
    КонецЕсли;
    
    ВызватьИсключение "Индекс выходит за границы коллекции";

КонецФункции

Функция Добавить(Адрес) Экспорт

	НовыйОбъект = Новый Маршрут(Адрес);
	МассивКоллекции.Добавить(НовыйОбъект);
	Возврат НовыйОбъект;

КонецФункции