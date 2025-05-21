#ifndef DATABASEWORKER_H
#define DATABASEWORKER_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QThread>
#include <QMutex>
#include "Project.h"


class DatabaseWorker : public QObject {
    Q_OBJECT

public:
    explicit DatabaseWorker(const QString& dbPath, QObject *parent = nullptr);
    ~DatabaseWorker();  

    Q_INVOKABLE void init();
    Q_INVOKABLE void addProject(const Project &project);

    bool isInitialized = false;

public slots:
    void getProjects();
    void deleteProject(int projectId);
    void editProject(const Project& project);
    void getProjectById(int projectId);


signals:
    void projectAdded(bool success, const QString& message);
    void projectsReady(const QList<Project>& projects);
    void errorOccurred(const QString& errorMessage);
    void projectDeleted(bool success, const QString& message);
    void projectEdited(bool success, const QString& message);
    void databaseInitialized();
    void singleProjectReady(const Project &project);

private:
    QString m_dbPath;
    QSqlDatabase db;
    mutable QMutex m_mutex;
    bool initializeDatabase();

};

#endif // DATABASEWORKER_H
