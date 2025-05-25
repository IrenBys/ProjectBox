#ifndef PROJECT_H
#define PROJECT_H

#include <QString>
#include <QDebug>
#include <QVariantMap>

class Project
{
public:
    Project() = default;
    Project(const QString &name, const QString &status, const QString &notes)
        : projectName(name), projectStatus(status), projectNotes(notes) {}

    int getProjectId() const { return projectId; }
    QString getProjectName() const { return projectName; }
    QString getProjectStatus() const { return projectStatus; }
    QString getProjectNotes() const { return projectNotes; }

    void setProjectId(const int &newProjectId) { projectId = newProjectId; }
    void setProjectName(const QString &newProjectName) { projectName = newProjectName; }
    void setProjectStatus(const QString &newProjectStatus) { projectStatus = newProjectStatus; }
    void setProjectNotes(const QString &newProjectNotes) { projectNotes = newProjectNotes; }

    QVariantMap toMap() const {
        QVariantMap map;
        map["id"] = projectId;
        map["name"] = projectName;
        map["status"] = projectStatus;
        map["notes"] = projectNotes;
        return map;
    }

    static Project fromMap(const QVariantMap &map) {
        Project p;
        if (map.contains("id")) p.setProjectId(map.value("id").toInt());
        if (map.contains("name")) p.setProjectName(map.value("name").toString());
        if (map.contains("status")) p.setProjectStatus(map.value("status").toString());
        if (map.contains("notes")) p.setProjectNotes(map.value("notes").toString());
        return p;
    }

private:
    int projectId;
    QString projectName;
    QString projectStatus;
    QString projectNotes;
};

#endif // PROJECT_H

