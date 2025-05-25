#ifndef PROJECTMODEL_H
#define PROJECTMODEL_H

#include <QAbstractListModel>
#include "Project.h"

class ProjectModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ProjectRole {
        IdRole = Qt::UserRole + 1,
        NameRole,
        StatusRole,
        NotesRole
    };

    explicit ProjectModel(QObject* parent = nullptr) : QAbstractListModel(parent) {}
    ~ProjectModel() override = default;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override; // Возвращаем количество строк в модели: количество проектов
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override; // Метод получения данных по индексу и роли
    QHash<int, QByteArray> roleNames() const override;  // Регистрируем роли для QML

    Q_INVOKABLE void addProject(const Project &project);    // Метод для добавления проекта
    Q_INVOKABLE void setProjects(const QList<Project> &projects);
    Q_INVOKABLE void clear();   // Очистка списка проектов
    Q_INVOKABLE void loadProjectsFromVariant(const QVariant &variantProjects);
    Q_INVOKABLE void updateProject(const Project &project);

private:
    QList<Project> m_projects;  // Список проектов
};

#endif // PROJECTMODEL_H
