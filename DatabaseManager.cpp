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

    // От менеджера воркеру
    bool databaseInitializConnected = connect(worker, &DatabaseWorker::databaseInitialized, this, &DatabaseManager::onDatabaseInitialized);
    qDebug() << "databaseInitialized and onDatabaseInitialized connect result:" << databaseInitializConnected;

    bool addConnected = connect(this, &DatabaseManager::requestAddProject, worker, &DatabaseWorker::addProject);
    qDebug() << "requestAddProject and addProject connect result:" << addConnected;

    bool connected = connect(this, &DatabaseManager::requestLoadProjects, worker, &DatabaseWorker::getProjects, Qt::QueuedConnection);
    qDebug() << "requestLoadProjects and getProjects connect result:" << connected;

    bool deleteConnected = connect(this, &DatabaseManager::requestDeleteProject, worker, &DatabaseWorker::deleteProject);
    qDebug() << "requestDeleteProject and deleteProject connect result:" << deleteConnected;

    bool editConnected = connect(this, &DatabaseManager::requestEditProject, worker, &DatabaseWorker::editProject);
    qDebug() << "requestEditProject and editProject connect result:" << editConnected;

    // От воркера менеджеру
    bool projectAddedConnected = connect(worker, &DatabaseWorker::projectAdded, this, &DatabaseManager::projectAdded);
    qDebug() << "projectAdded and projectAdded connect result:" << projectAddedConnected;

    bool projectReadyConnected = connect(worker, &DatabaseWorker::projectsReady, this, &DatabaseManager::onProjectsReady);
    qDebug() << "projectsReady and projectsReady connect result:" << projectReadyConnected;

    bool projectDeletedConnected = connect(worker, &DatabaseWorker::projectDeleted, this, &DatabaseManager::onProjectDeleted);
    qDebug() << "projectDeleted and onProjectDeleted connect result:" << projectDeletedConnected;

    bool projectEditedConnected = connect(worker, &DatabaseWorker::projectEdited, this, &DatabaseManager::onProjectEdited);
    qDebug() << "projectEdited and onProjectEdited connect result:" << projectEditedConnected;

    bool getProjectConnected = connect(this, &DatabaseManager::requestProjectById,
                                       worker, &DatabaseWorker::getProjectById);
    qDebug() << "requestProjectById и getProjectById connect result:" << getProjectConnected;

    bool singleProjectConnected = connect(worker, &DatabaseWorker::singleProjectReady,
                                          this, &DatabaseManager::onSingleProjectReady);
    qDebug() << "singleProjectReady и onSingleProjectReady connect result:" << singleProjectConnected;

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
        map["id"] = proj.getProjectId();
        map["name"] = proj.getProjectName();
        map["status"] = proj.getProjectStatus();
        qDebug() << "QVariantMap из DatabaseManager::onProjectsReady" << map;
        variantProjects.append(map);
    }

    qDebug() << "Дополнительно преобразуем для QML: " << variantProjects.data();
    emit projectsReadyForQml(variantProjects);  // Отправляем в QML
}

void DatabaseManager::onProjectDeleted(bool success, const QString &message) {
    qDebug() << "==> onProjectDeleted в DatabaseManager, success:" << success << ", message:" << message;
    emit projectDeleted(success, message);  // ← Прокидываем в QML
}

void DatabaseManager::onProjectEdited(bool success, const QString &message)
{
    qDebug() << "==> onProjectEdited в DatabaseManager, success:" << success << ", message:" << message;
    emit projectEdited(success, message);  // Прокидываем в QML
}

void DatabaseManager::onSingleProjectReady(const Project &project)
{
    qDebug() << "==> onSingleProjectReady в DatabaseManager. Получен проект:" << project.getProjectId();

    QVariantMap map;
    map["id"] = project.getProjectId();
    map["name"] = project.getProjectName();
    map["status"] = project.getProjectStatus();

    emit singleProjectReadyForQml(map);  // если нужно пробросить в QML
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
}

void DatabaseManager::loadProjects() {
    qDebug() << "==> Вызван loadProjects()";
    emit requestLoadProjects();
}

void DatabaseManager::deleteProject(int projectId)
{
    qDebug() << "==> Вызван deleteProject(int projectId) для проекта с ID" << projectId;
    emit requestDeleteProject(projectId);
}

void DatabaseManager::editProjectFromQml(int id, const QString &name, const QString &status)
{
    Project p;
    p.setProjectId(id);
    p.setProjectName(name);
    p.setProjectStatus(status);
    editProject(p);
}

void DatabaseManager::editProject(const Project &project)
{
    qDebug() << "==> Вызван editProject(Project &project) для проекта "
             << project.getProjectId() << " "
             << project.getProjectName() << " "
             << project.getProjectStatus() << " ";

    emit requestEditProject(project);
}

void DatabaseManager::loadProjectById(int id)
{
    qDebug() << "==> Вызван loadProjectById с ID:" << id;
    emit requestProjectById(id);
}



















