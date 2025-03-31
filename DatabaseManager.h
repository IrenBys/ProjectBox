#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QThread>
#include "DatabaseWorker.h"


class DatabaseManager : public QObject
{
    Q_OBJECT

public:

    explicit DatabaseManager(QObject *parent = nullptr);
    ~DatabaseManager();

    Q_INVOKABLE void addProject(const QString &projectName);
    Q_INVOKABLE void loadProjects();

signals:
    void requestAddProject(const QString &projectName);
    void requestLoadProjects();
    void projectAdded(bool success);
    void projectsLoaded(QStringList projects);

private:
    QThread dbThread;
    DatabaseWorker *dbWorker;
};

#endif // DATABASEMANAGER_H
