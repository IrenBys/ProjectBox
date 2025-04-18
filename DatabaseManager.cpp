#include "DatabaseManager.h"
#include <QSqlQuery>



// В конструкторе ирициализируем БД
DatabaseManager::DatabaseManager(const QString &dbPath, QObject *parent)
    : QObject(parent),
    worker(nullptr)
{


    // Создаем воркера и подключаем его к потоку
    worker = new DatabaseWorker(dbPath);;
    worker->moveToThread(&workerThread);

    // Подключаем сигналы и слоты

    connect(&workerThread, &QThread::started, worker, &DatabaseWorker::init);

    connect(this, &DatabaseManager::requestAddProject, worker, &DatabaseWorker::addProject);
    //connect(this, &DatabaseManager::requestLoadProjects, worker, &DatabaseWorker::getProjects);

    connect(worker, &DatabaseWorker::projectAdded, this, &DatabaseManager::projectAdded);
    //connect(worker, &DatabaseWorker::projectsReady, this, &DatabaseManager::projectsReady);
    connect(worker, &DatabaseWorker::errorOccurred, this, &DatabaseManager::errorOccurred);

    // Запускаем поток
    workerThread.start();
}

//В деструкторе закрываем соединеие БД
DatabaseManager::~DatabaseManager()
{
    // Завершаем работу потока и удаляем воркер
    workerThread.quit();
    workerThread.wait();
    worker->deleteLater();
}

void DatabaseManager::addProject(const QString &name, const QString &status)
{
    qDebug() << "Создаем Project внутри DatabaseManager";

    // Создаём Project
    Project project;
    project.setProjectName(name);
    project.setProjectStatus(status);

    // Отправляем во внешний мир (например, в DatabaseWorker)
    emit requestAddProject(project);
}

/*
void DatabaseManager::loadProjects()
{
    emit requestLoadProjects();
}*/






