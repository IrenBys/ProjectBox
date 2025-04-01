#include "DatabaseManager.h"
#include <QSqlQuery>


// В конструкторе ирициализируем БД
DatabaseManager::DatabaseManager(const QString &dbPath, QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE"); //создаёт новое подключение к базе данных SQLite
    db.setDatabaseName(dbPath); // устанавливает имя файла БД (он будет создан в корне проекта, если его нет)

    if(!initializeDatabase())
    {
        qDebug() << "Ошибка инициализации БД";
    }
}

//В деструкторе закрываем соединеие БД
DatabaseManager::~DatabaseManager()
{
    if(db.isOpen())
    {
        db.close();
        qDebug() << "Соединение с БД закрыто";
    }
}

bool DatabaseManager::initializeDatabase()
{

    if(!db.open()) {
        qDebug() << "Ошибка при открытии БД" << db.lastError().text();
        return false;
    }

    qDebug() << "База данных успешно открыта: " << db.databaseName();

    // Создание таблицы
    QSqlQuery query; // класс, который выполняет SQL запросы

    QString createTableQuery = R"(
        CREATE TABLE IF NOT EXISTS projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE,
            status TEXT NOT NULL
        )
    )";

    /* id       INTEGER PRIMARY KEY AUTOINCREMENT   Уникальный ID проекта, автоувеличивается
     * name     TEXT NOT NULL UNIQUE                Название проекта, уникальное
     * status   TEXT NOT NULL                       Статус проекта
    */


    // Выполнение SQL-запроса  на создание таблицы
    if(!query.exec(createTableQuery))
    {
        qDebug() << "Ошибка создания таблицы: " << query.lastError().text();
        return false;
    }

    qDebug() << "Таблица 'projects' проверена/создана";
    return true;
}

QSqlDatabase& DatabaseManager::getDatabase()
{
    return db;
}




