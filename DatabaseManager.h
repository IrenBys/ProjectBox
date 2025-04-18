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
    //Q_INVOKABLE void loadProjects();

signals:
    void requestAddProject(const Project &project);
    //void requestLoadProjects();

    // Проброс сигналов от воркера наружу
    void projectAdded(bool success, const QString& message);
    //void projectsReady(const QList<Project>& projects);
    void errorOccurred(const QString& errorMessage);




private:

    QThread workerThread;
    DatabaseWorker* worker = nullptr;


};

#endif // DATABASEMANAGER_H
