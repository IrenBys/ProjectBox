#ifndef DATABASEWORKER_H
#define DATABASEWORKER_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QThread>
#include "Project.h"


class DatabaseWorker : public QObject {
    Q_OBJECT

public:
    explicit DatabaseWorker(const QString& dbPath, QObject *parent = nullptr);
    ~DatabaseWorker();

    QSqlDatabase& getDatabase(); // Передает соединение с БД

    Q_INVOKABLE void init();
    Q_INVOKABLE void addProject(const Project &project);
    //Q_INVOKABLE QList<Project> getProjects();

    bool isInitialized = false;

signals:
    void projectAdded(bool success, const QString& message);
    //void projectsReady(const QList<Project>& projects);
    void errorOccurred(const QString& errorMessage);

private:
    QString m_dbPath;
    QSqlDatabase db;
    bool initializeDatabase();

};

#endif // DATABASEWORKER_H
