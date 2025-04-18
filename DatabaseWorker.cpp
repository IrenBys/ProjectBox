#include "DatabaseWorker.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QThread>
#include <QFile>


DatabaseWorker::DatabaseWorker(const QString& dbPath, QObject *parent)
    : QObject(parent),
      m_dbPath(dbPath)
{


    qDebug() << "DatabaseWorker создан (но БД ещё не инициализирована)";
}

DatabaseWorker::~DatabaseWorker()
{
    if(db.isOpen())
    {
        db.close();
        qDebug() << "Соединение с БД закрыто";
    } else {
        qDebug() << "База данных уже была закрыта.";
    }
    qDebug() << "DatabaseWorker уничтожен в потоке:" << QThread::currentThread();
}

bool DatabaseWorker::initializeDatabase()
{

    if(!db.open()) {
        qCritical() << "Ошибка при открытии БД" << db.lastError().text();
        return false;
    }

    qDebug() << "База данных успешно открыта: " << db.databaseName();

    // Создание таблицы
    QSqlQuery query(db);  // класс, который выполняет SQL запросы

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
        qCritical() << "Ошибка создания таблицы: " << query.lastError().text();
        return false;
    }

    qDebug() << "Таблица 'projects' проверена/создана";
    return true;
}

QSqlDatabase &DatabaseWorker::getDatabase()
{
    return db;
}

void DatabaseWorker::init()
{
    db = QSqlDatabase::addDatabase("QSQLITE", "WorkerConnection"); // добавим имя соединения

    qDebug() << "Доступные драйверы:" << QSqlDatabase::drivers();
    qDebug() << "Имя подключения:" << db.connectionName();

    if (QFile::exists(m_dbPath)) {
        QFile::remove(m_dbPath);
        qDebug() << "Старая база данных удалена:" << m_dbPath;
    }

    db.setDatabaseName(m_dbPath);

    // Попробуем открыть базу до инициализации
    if (!db.open()) {
        qCritical() << "Ошибка открытия БД:" << db.lastError().text();
    } else {
        qDebug() << "Соединение открыто:" << db.isOpen();
    }

    if (!initializeDatabase()) {
        qCritical() << "Ошибка инициализации БД";
    }

    isInitialized = true;
    qDebug() << "DatabaseWorker: инициализация завершена";
}



void DatabaseWorker::addProject(const Project &project)
{
    if (!isInitialized) {
        QString error = "Попытка добавить проект до инициализации базы данных!";
        qDebug() << error;
        emit errorOccurred(error);
        emit projectAdded(false, error);
        return;
    }

    if (!db.isOpen()) {
        QString error = "База данных закрыта при добавлении проекта";
        qDebug() << error;
        emit errorOccurred(error);
        emit projectAdded(false, error);
        return;
    }

    QString name = project.getProjectName().trimmed();
    QString status = project.getProjectStatus().trimmed();

    if (name.isEmpty()) {
        QString err = "Название проекта не может быть пустым.";
        emit projectAdded(false, err);
        emit errorOccurred(err);
        return;
    }

    if (status.isEmpty()) {
        QString err = "Статус проекта не может быть пустым.";
        emit projectAdded(false, err);
        emit errorOccurred(err);
        return;

    }

    qDebug() << "Добавление проекта:" << name << status;

    // Подготовка SQL-запроса для добавления проекта в базу данных
    QSqlQuery query(db);
    qDebug() << "Добавление проекта. Соединение:" << db.connectionName();
    query.prepare("INSERT INTO projects(name, status) VALUES (:n, :s)");
    query.bindValue(":n", project.getProjectName());
    if (query.lastError().isValid()) {
        qCritical() << "Ошибка привязки параметра :name" << query.lastError().text();
    }

    query.bindValue(":s", project.getProjectStatus());
    if (query.lastError().isValid()) {
        qCritical() << "Ошибка привязки параметра :status" << query.lastError().text();
    }


    if(!query.exec())
    {
        QString err = query.lastError().text();
        emit projectAdded(false, err);
        emit errorOccurred(err);
        qDebug() << "Ошибка при добавлении проекта: " << err;
    } else {
        qDebug() << "Проект добавлен в БД:" << project.getProjectName() << project.getProjectStatus();
        emit projectAdded(true, "Проект успешно добавлен.");
    }

}

/*
QList<Project> DatabaseWorker::getProjects()
{
    // Создаём пустой список, в который мы будем складывать все загруженные из базы проекты.
    QList<Project> projects;
    // Создаем запрос на извлечение из таблицы
    QSqlQuery query("SELECT name, status FROM projects");

    if(!query.exec())
    {
        QString err = query.lastError().text();
        emit errorOccurred(err);
        emit projectsReady({});
        qDebug() << "Ошибка при получении проектов: " << query.lastError().text();
        return {}; // возвращаем пустой список, чтобы не крашить приложение
    }

    //Начинаем обход результатов запроса
    while(query.next())
    {
        QString name = query.value(0).toString();
        QString status = query.value(1).toString();

        Project project;
        project.setProjectName(name);
        project.setProjectStatus(status);

        projects.append(project);
    }

    emit projectsReady(projects);
    return projects;
}*/
