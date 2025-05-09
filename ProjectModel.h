#ifndef PROJECTMODEL_H
#define PROJECTMODEL_H

#include <QAbstractListModel>
#include "Project.h"

class ProjectModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ProjectRole {
        NameRole = Qt::UserRole + 1,
        StatusRole
    };

    explicit ProjectModel(QObject* parent = nullptr) : QAbstractListModel(parent) {}

    ~ProjectModel() override = default;

    // Возвращаем количество строк в модели: количество проектов
    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
       // qDebug() << "Вызов метода rowCount из  ProjectModel";
        if (parent.isValid()) {
            return 0;  // Если родительский индекс невалиден, возвращаем 0
        }
        //qDebug() << "m_projects.size() = " << m_projects.size();
        return m_projects.size();  // Возвращаем количество проектов
    }

    // Метод получения данных по индексу и роли
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override {
        if (!index.isValid() || index.row() < 0 || index.row() >= m_projects.size())
            return QVariant();

        const Project &project = m_projects.at(index.row());

        switch (role) {
        case NameRole:
            return project.getProjectName();
        case StatusRole:
            return project.getProjectStatus();
        default:
            return QVariant();
        }
    }

    // Регистрируем роли для QML
    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[NameRole] = "name";
        roles[StatusRole] = "status";
        return roles;
    }

    // Метод для добавления проекта
    Q_INVOKABLE void addProject(const Project &project) {
        //qDebug() << "Вызов метода addProject из  ProjectModel";
        beginInsertRows(QModelIndex(), m_projects.size(), m_projects.size());
        m_projects.append(project);
        endInsertRows();
    }

    Q_INVOKABLE void setProjects(const QList<Project> &projects) {
        //qDebug() << "Вызов метода setProjects из  ProjectModel";
        beginResetModel();  // Сброс модели
        m_projects = projects;
        endResetModel();    // Завершаем сброс модели
    }


    // Очистка списка проектов
    Q_INVOKABLE void clear() {
        //qDebug() << "Вызов метода clear из  ProjectModel";
        beginResetModel();  // Начинаем сброс модели
        m_projects.clear(); // Очищаем список проектов
        endResetModel();    // Завершаем сброс модели
    }

    Q_INVOKABLE void loadProjectsFromVariant(const QVariant &variantProjects) {
        //qDebug() << "Вызов loadProjectsFromVariant";

        clear();  // очищаем старые проекты

        QVariantList projectList = variantProjects.toList();
        beginResetModel();
        for (const QVariant &var : projectList) {
            QVariantMap map = var.toMap();
            Project project;
            project.setProjectName(map.value("name").toString());
            project.setProjectStatus(map.value("status").toString());
            m_projects.append(project);
        }
        endResetModel();
    }

private:
    QList<Project> m_projects;  // Список проектов
};

#endif // PROJECTMODEL_H
