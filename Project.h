#ifndef PROJECT_H
#define PROJECT_H

#include <QObject>
#include <QString>

class Project : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getProjectName WRITE setProjectName NOTIFY projectNameChanged)
    Q_PROPERTY(QString status READ getProjectStatus WRITE setProjectStatus NOTIFY projectStatusChanged)


public:
    Project(QObject *parent = nullptr) :
        QObject(parent),
        projectName(""),
        projectStatus("")
    {};
    virtual ~Project() {};

    QString getProjectName () const { return projectName; };
    QString getProjectStatus () const { return projectStatus; };

    void setProjectName (const QString &newProjectName) {
        if(projectName != newProjectName) {
            projectName = newProjectName;
            emit projectNameChanged();
        }
    }

    void setProjectStatus (const QString &newProjectStatus) {
        if(projectStatus != newProjectStatus) {
            projectStatus = newProjectStatus;
            emit projectStatusChanged();
        }
    }

signals:
    void projectNameChanged();
    void projectStatusChanged();

private:
    QString projectName;
    QString projectStatus;

};


#endif // PROJECT_H
