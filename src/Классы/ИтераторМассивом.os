Перем Индекс;
Перем Коллекция;

Процедура ПриСозданииОбъекта(ОбъектКоллекции)

    Коллекция = ОбъектКоллекции;
    Индекс = 0;

КонецПроцедуры

Функция Следующий()

    Если Индекс <= Коллекция.Количество() - 1 Тогда
        Возврат Истина;
    Иначе
        Возврат Ложь;    
    КонецЕсли;

КонецФункции

Функция ТекущийЭлемент()

    ЭлементКоллекции = Коллекция.Получить(Индекс);
    Индекс = Индекс + 1;
    Возврат ЭлементКоллекции;
    
КонецФункции