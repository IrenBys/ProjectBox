#include "DatabaseManager.h"
#include <QDir>               // Для работы с каталогами

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
    if(!initializeDatebase()) {
        qDebug() << "Не удалось инициализировать БД";
    }
}

DatabaseManager::~DatabaseManager()
{
    if(db.isOpen()) {
        db.close();
        qDebug() << "Соединение с БД закрыто";
    }
}

bool DatabaseManager::initializeDatebase()
{
    // Попробуем удалить старую базу данных, если она существует
    if (QFile::remove("projects.db")) {
        qDebug() << "Старая база данных удалена.";
    } else {
        qDebug() << "База данных не найдена или не была удалена.";
    }

    // Указываем, что используем SQLite
    db = QSqlDatabase::addDatabase("QSQLITE");

    // Задаём путь к файлу базы данных
    QString dbPath = QDir::currentPath() + "/projects.db";
    db.setDatabaseName(dbPath); // связывает объект базы данных с этим файлом

    // Пытаемся открыть базу данных
    if(!db.open()) {
        qDebug() << "Ошибка при открытии БД:" << db.lastError().text();
        return false;
    }

    // Создаём таблицу "projects", если её ещё нет
    QSqlQuery query;
    QString createTableQuery = R"(
        CREATE TABLE IF NOT EXISTS projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
        )
    )";

    if(!query.exec(createTableQuery)) {
        qDebug() << "Ошибка при создании таблицы:" << query.lastError().text();
        return false;
    }

    qDebug() << "База данных создана по пути:" << dbPath;
    return true;
}


bool DatabaseManager::addProject(const QString &projectName)
{
    QSqlQuery query;
    query.prepare("INSERT INTO projects (name) VALUES (:name)");
    query.bindValue(":name", projectName);

    if (!query.exec()) {
        qDebug() << "Ошибка при добавлении проекта:" << query.lastError().text();
        return false;
    }

    qDebug() << "Проект успешно добавлен:" << projectName;
    return true;
}

QStringList DatabaseManager::getProjects()
{
    QStringList projects;

    if(!db.isOpen()) {
        qDebug() << "БД не открыта";
        return projects;
    }

    // Пишем SQL-запрос для получения всех проектов
    QSqlQuery query;
    query.prepare("SELECT name FROM projects");

    if (query.exec()) {
        while (query.next()) {
            // Получаем название проекта и добавляем в список
            QString projectName = query.value(0).toString();
            projects.append(projectName);
        }
    } else {
        qDebug() << "Ошибка при получении проектов:" << query.lastError().text();
    }

    qDebug() << "Загружено проектов:" << projects.size();
    return projects;
}

