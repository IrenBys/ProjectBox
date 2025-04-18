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

    QString getProjectName() const { return projectName; }
    QString getProjectStatus() const { return projectStatus; }

    void setProjectName(const QString &newProjectName) { projectName = newProjectName; }
    void setProjectStatus(const QString &newProjectStatus) { projectStatus = newProjectStatus; }

private:
    QString projectName;
    QString projectStatus;
};

#endif // PROJECT_H

