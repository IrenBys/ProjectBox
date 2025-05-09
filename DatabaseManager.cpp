#include "DatabaseManager.h"
#include <QSqlQuery>
#include <QTimer>
#include "ProjectModel.h"



// В конструкторе ирициализируем БД
DatabaseManager::DatabaseManager(const QString &dbPath, QObject *parent)
    : QObject(parent),
    worker(nullptr)
{


    // Создаем воркера и подключаем его к потоку

    worker = new DatabaseWorker(dbPath);
    worker->moveToThread(&workerThread);
    qDebug() << "Создаем воркера и подключаем его к потоку" << worker;
    qDebug() << "worker->moveToThread" << &workerThread;


    // Подключаем сигналы и слоты

    bool initConnected = connect(&workerThread, &QThread::started, worker, &DatabaseWorker::init);
    qDebug() << "started and init connect result:" << initConnected;

    bool databaseInitializConnected = connect(worker, &DatabaseWorker::databaseInitialized, this, &DatabaseManager::onDatabaseInitialized);
    qDebug() << "databaseInitialized and onDatabaseInitialized connect result:" << databaseInitializConnected;

    bool addConnected = connect(this, &DatabaseManager::requestAddProject, worker, &DatabaseWorker::addProject);
    qDebug() << "requestAddProject and addProject connect result:" << addConnected;

    bool connected = connect(this, &DatabaseManager::requestLoadProjects, worker, &DatabaseWorker::getProjects, Qt::QueuedConnection);
    qDebug() << "requestLoadProjects and getProjects connect result:" << connected;

    connect(worker, &DatabaseWorker::projectAdded, this, &DatabaseManager::projectAdded);


    bool readyConnected = connect(worker, &DatabaseWorker::projectsReady, this, &DatabaseManager::onProjectsReady);
    qDebug() << "projectsReady and projectsReady connect result:" << readyConnected;

    bool errorConnected = connect(worker, &DatabaseWorker::errorOccurred, this, &DatabaseManager::errorOccurred);
    qDebug() << "errorOccurred and errorOccurred connect result:" << errorConnected;

    // Запускаем поток
    workerThread.start();
    qDebug() << "DatabaseWorker: Поток запущен";
    loadProjects();
}

//В деструкторе закрываем соединеие БД
DatabaseManager::~DatabaseManager()
{
    qDebug() << "Завершаем работу потока и удаляем воркер" << worker;
    workerThread.quit();
    workerThread.wait();
    worker->deleteLater();
}


void DatabaseManager::addProject(const QString &name, const QString &status)
{
    qDebug() << "Добавление проекта в БД через менеджер:" << name << status;

    // Создаём Project
    Project project;
    project.setProjectName(name);
    project.setProjectStatus(status);

    // Отправляем во внешний мир (например, в DatabaseWorker)
    emit requestAddProject(project);
    loadProjects();
}

void DatabaseManager::onDatabaseInitialized() {
    qDebug() << "База данных инициализирована, теперь можно работать с проектами.";
    // Теперь загружаем проекты только после полной инициализации базы данных
    loadProjects();
}

void DatabaseManager::onProjectsReady(const QList<Project> &projects) {
    qDebug() << "Проекты загружены, количество: " << projects.size();
    emit projectsReady(projects);  // Пробрасываем для внутренней логики

    // Дополнительно преобразуем для QML
    QVariantList variantProjects;
    for (const Project &proj : projects) {
        QVariantMap map;
        map["name"] = proj.getProjectName();
        map["status"] = proj.getProjectStatus();
        variantProjects.append(map);
    }

    qDebug() << "Дополнительно преобразуем для QML: " << variantProjects.data();
    emit projectsReadyForQml(variantProjects);  // Отправляем в QML
}

void DatabaseManager::loadProjects() {
    qDebug() << "==> Вызван loadProjects()";
    emit requestLoadProjects();
}















