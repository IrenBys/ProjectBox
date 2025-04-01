#ifndef DATABASEWORKER_H
#define DATABASEWORKER_H

#include <QDebug>
#include <QObject>
//#include <QList>
#include "Project.h"


class DatabaseWorker : public QObject {
    Q_OBJECT

public:
    explicit DatabaseWorker(QObject *parent = nullptr);
    ~DatabaseWorker();

    Q_INVOKABLE void addProject(const Project &project);
    Q_INVOKABLE QList<Project> getProjects();


};

#endif // DATABASEWORKER_H
