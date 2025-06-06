#include "DatabaseWorker.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QThread>
#include <QFile>
#include <QMutexLocker>

DatabaseWorker::DatabaseWorker(const QString& dbPath, QObject *parent)
    : QObject(parent),
      m_dbPath(dbPath)
{
    qDebug() << "DatabaseWorker создан (но БД ещё не инициализирована)";
    qDebug() << "DatabaseWorker создан:" << this;
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
    //QMutexLocker locker(&m_mutex);

    qDebug() << "==> Вызван initializeDatabase() в DatabaseWorker";

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
            status TEXT NOT NULL,
            notes TEXT DEFAULT ''
        )
    )";

    /* id       INTEGER PRIMARY KEY AUTOINCREMENT   Уникальный ID проекта, автоувеличивается
     * name     TEXT NOT NULL UNIQUE                Название проекта, уникальное
     * status   TEXT NOT NULL                       Статус проекта
     * notes TEXT DEFAULT ''                        Заметки
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

void DatabaseWorker::init()
{
    //QMutexLocker locker(&m_mutex);

    qDebug() << "==> Вызван init() в DatabaseWorker";

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
        return;  // Это остановит дальнейшее выполнение
    } else {
        qDebug() << "Соединение открыто:" << db.isOpen();
    }

    if (!initializeDatabase()) {
        qCritical() << "Ошибка инициализации БД";
        return;  // Это остановит дальнейшее выполнение
    } else {
        qDebug() << "Инициализация БД успешна";
    }

    isInitialized = true;
    qDebug() << "DatabaseWorker::init() закончен, isInitialized =" << isInitialized;
    emit databaseInitialized();
}



void DatabaseWorker::addProject(const Project &project)
{
     //QMutexLocker locker(&m_mutex);

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

    // Подготовка SQL-запроса для добавления проекта в базу данных
    QSqlQuery query(db);
    qDebug() << "Добавление проекта. Соединение:" << db.connectionName();
    query.prepare("INSERT INTO projects(name, status, notes) VALUES (:n, :s, :notes)");
    query.bindValue(":n", project.getProjectName());
    if (query.lastError().isValid()) {
        qCritical() << "Ошибка привязки параметра :name" << query.lastError().text();
    }
    query.bindValue(":s", project.getProjectStatus());
    if (query.lastError().isValid()) {
        qCritical() << "Ошибка привязки параметра :status" << query.lastError().text();
    }
    query.bindValue(":notes", project.getProjectNotes());

    if(!query.exec())
    {
        QString err = query.lastError().text();
        emit projectAdded(false, err);
        emit errorOccurred(err);
        qDebug() << "Ошибка при добавлении проекта: " << err;
    } else {
        qDebug() << "Проект добавлен в БД:"
                 << query.lastInsertId().toInt() << " "
                 << project.getProjectName() << " "
                 << project.getProjectStatus();
        emit projectAdded(true, "Проект успешно добавлен.");
    }
}

void DatabaseWorker::getProjects()
{
    //QMutexLocker locker(&m_mutex);

    qDebug() << "==> Вызван getProjects() в DatabaseWorker";

    // Создаём пустой список, в который мы будем складывать все загруженные из базы проекты.
    QList<Project> projects;

    if (!isInitialized) {
        QString error = "База данных не инициализирована при попытке загрузки проектов.";
        qCritical() << error;
        emit errorOccurred(error);
        emit projectsReady(projects);  // Возвращаем пустой список
        return;
    }

    if (!db.isOpen()) {
        QString error = "База данных закрыта при попытке загрузки проектов.";
        qCritical() << error;
        emit errorOccurred(error);
        emit projectsReady(projects);  // Возвращаем пустой список
        return;
    }


    // Создаем запрос на извлечение из таблицы
    QSqlQuery query(db);

    if (!query.exec("SELECT id, name, status, notes FROM projects")) {
        QString error = "Ошибка выполнения запроса SELECT: " + query.lastError().text();
        qCritical() << error;
        emit errorOccurred(error);
        emit projectsReady(projects);  // Возвращаем пустой список
        return;
    }

    //Начинаем обход результатов запроса
    while (query.next()) {
        int id = query.value(0).toInt();
        QString name = query.value(1).toString();
        QString status = query.value(2).toString();
        QString notes  = query.value(3).toString();

        Project project;
        project.setProjectId(id);
        project.setProjectName(name);
        project.setProjectStatus(status);
        project.setProjectNotes(notes);

        qDebug() << "В Databaseworker получен проект из БД:"
                 << project.getProjectId()
                 << project.getProjectName()
                 << project.getProjectStatus();
        projects.append(project);
    }

    qDebug() << "Получено проектов из БД:" << projects.size();
    emit projectsReady(projects);  // Возвращаем результат через сигнал;
}

void DatabaseWorker::deleteProject(int projectId)
{
    //QMutexLocker locker(&m_mutex);
    qDebug() << "==> Вызван deleteProject(int projectId) в DatabaseWorker для проекта с ID" << projectId;

    QSqlQuery query(db);
    query.prepare("DELETE FROM projects WHERE id = :id");
    query.bindValue(":id", projectId);

    if (!query.exec()) {
        emit errorOccurred("Ошибка при удалении проекта: " + query.lastError().text());
    } else {
        qDebug() << "Проект удалён, id =" << projectId;
        emit projectDeleted(true, "Проект удалён");
    }

}

void DatabaseWorker::editProject(const Project& project) {
    qDebug() << "==> Вызван editProject для проекта с ID" << project.getProjectId();

    if (!db.isOpen()) {
        qWarning() << "Ошибка: база данных не открыта!";
        emit projectEdited(false, "База данных не открыта");
        return;
    }

    QSqlQuery query(db);
    query.prepare("UPDATE projects SET name = :name, status = :status, notes = :notes WHERE id = :id");
    query.bindValue(":name", project.getProjectName());
    query.bindValue(":status", project.getProjectStatus());
    query.bindValue(":id", project.getProjectId());
    query.bindValue(":notes", project.getProjectNotes());

    if (!query.exec()) {
        qWarning() << "Ошибка SQL:" << query.lastQuery();
        qWarning() << "Параметры:" << query.boundValues();
        qWarning() << "Ошибка при редактировании проекта:" << query.lastError().text();
        emit projectEdited(false, "Ошибка при редактировании проекта: " + query.lastError().text());
    } else if (query.numRowsAffected() == 0) {
        qWarning() << "Запрос выполнен, но строки не были изменены (возможно, проект с ID не найден)";
        emit projectEdited(false, "Проект с таким ID не найден или данные совпадают");
    } else {
        qDebug() << "Проект успешно отредактирован:"
                 << project.getProjectId() << project.getProjectStatus() << project.getProjectName();
        emit projectEdited(true, "Проект успешно отредактирован");
    }
}

void DatabaseWorker::getProjectById(int projectId)
{
    qDebug() << "==> Вызван getProjectById(int projectId) в DatabaseWorker c projectId: " << projectId;

    if(!isInitialized) {
        QString error = "База данных не инициализирована при попытке загрузки проекта";
        qCritical() << error;
        emit errorOccurred(error);
        return;
    }

    if(!db.isOpen()) {
        QString error = "База данных закрыта при попытке загрузки проетка";
        qCritical() << error;
        emit errorOccurred(error);
        return;
    }

    QSqlQuery query(db);
    query.prepare("SELECT id, name, status, notes FROM projects WHERE id = :id");
    query.bindValue(":id", projectId);

    if (!query.exec()) {
        QString error = "Ошибка выполнения запроса SELECT: " + query.lastError().text();
        qCritical() << error;
        emit errorOccurred(error);
        return;
    }

    if (query.next()) {
        Project project;
        project.setProjectId(query.value(0).toInt());
        project.setProjectName(query.value(1).toString());
        project.setProjectStatus(query.value(2).toString());
        project.setProjectNotes(query.value(3).toString());

        qDebug() << "Проект найден в DatabaseWorker:" << project.getProjectId() << project.getProjectName();

        emit singleProjectReady(project);
    } else {
        QString error = "Проект с ID " + QString::number(projectId) + " не найден.";
        qWarning() << error;
        emit errorOccurred(error);
    }
}

