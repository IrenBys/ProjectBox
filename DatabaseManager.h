#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QThread>
#include "DatabaseWorker.h"
#include "Project.h"


class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(const QString& dbPath, QObject *parent = nullptr);
    ~DatabaseManager();



    // Методы для взаимодействия с воркером
    Q_INVOKABLE void addProject(const QString &name, const QString &status);
    Q_INVOKABLE void loadProjects();
    Q_INVOKABLE void deleteProject(int projectId);
    Q_INVOKABLE void editProjectFromQml(int id, const QString &name, const QString &status);
    void editProject(const Project& project);
    Q_INVOKABLE void loadProjectById(int id);


signals:
    void requestAddProject(const Project &project);
    void requestLoadProjects();
    void requestDeleteProject(int projectId);
    void requestEditProject(const Project& project);
    void requestProjectById(int id);

    // Проброс сигналов от воркера наружу
    void projectAdded(bool success, const QString& message);
    void projectsReady(const QList<Project>& projects);
    void errorOccurred(const QString& errorMessage);
    void projectsReadyForQml(const QVariantList &projects);  // Новый для QML
    void projectDeleted(bool success, const QString& message);
    void projectEdited(bool success, const QString& message);
    void projectLoaded(const Project &project);
    void singleProjectReadyForQml(const QVariantMap &project);

private slots:
    void onDatabaseInitialized();
    void onProjectsReady(const QList<Project> &projects); // <-- слот для приёма данных
    void onProjectDeleted(bool success, const QString& message);
    void onProjectEdited(bool success, const QString& message);
    void onSingleProjectReady(const Project &project);

private:
    QThread workerThread;
    DatabaseWorker* worker = nullptr;
};

#endif // DATABASEMANAGER_H
