#Использовать onecore

// Подключение функционала
Приложение.ИспользоватьORM();
Приложение.ПодключитьБазуДанныхORM("Основная", "КоннекторSQLite", "FullUri=file:main.db");

// Подключение компонентов
Приложение.ПодключитьКомпонент("Основной", "main", Истина);

// Инициализация и запуск
Приложение.Инициализировать();
Приложение.Запустить();