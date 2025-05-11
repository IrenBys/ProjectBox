#ifndef PROJECT_H
#define PROJECT_H

#include <QString>
#include <QDebug>

class Project
{
public:
    Project() = default;
    Project(const QString &name, const QString &status)
        : projectName(name), projectStatus(status) {}

    int getProjectId() const { return projectId; }
    QString getProjectName() const { return projectName; }
    QString getProjectStatus() const { return projectStatus; }

    void setProjectId(const int &newProjectId) { projectId = newProjectId; }
    void setProjectName(const QString &newProjectName) { projectName = newProjectName; }
    void setProjectStatus(const QString &newProjectStatus) { projectStatus = newProjectStatus; }

private:
    int projectId;
    QString projectName;
    QString projectStatus;
};

#endif // PROJECT_H

