#include "ProjectModel.h"


int ProjectModel::rowCount(const QModelIndex &parent) const {
    // qDebug() << "Вызов метода rowCount из  ProjectModel";
    if (parent.isValid()) {
        return 0;  // Если родительский индекс невалиден, возвращаем 0
    }
    //qDebug() << "m_projects.size() = " << m_projects.size();
    return m_projects.size();  // Возвращаем количество проектов
}

QVariant ProjectModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() < 0 || index.row() >= m_projects.size())
        return QVariant();

    const Project &project = m_projects.at(index.row());
    int id = project.getProjectId();

    switch (role) {
    case IdRole:
        qDebug() << "Получаем Id для модели: " << id;
        return id;
    case NameRole:
        return project.getProjectName();
    case StatusRole:
        return project.getProjectStatus();
    case NotesRole:
        return project.getProjectNotes();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ProjectModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[StatusRole] = "status";
    roles[NotesRole] = "notes";
    return roles;
}

void ProjectModel::addProject(const Project &project) {
    qDebug() << "Вызов метода addProject из  ProjectModel";
    beginInsertRows(QModelIndex(), m_projects.size(), m_projects.size());
    m_projects.append(project);
    endInsertRows();
}

void ProjectModel::setProjects(const QList<Project> &projects) {
    qDebug() << "Вызов метода setProjects из  ProjectModel";
    beginResetModel();  // Сброс модели
    m_projects = projects;
    endResetModel();    // Завершаем сброс модели
}

void ProjectModel::clear() {
    //qDebug() << "Вызов метода clear из  ProjectModel";
    beginResetModel();  // Начинаем сброс модели
    m_projects.clear(); // Очищаем список проектов
    endResetModel();    // Завершаем сброс модели
}

void ProjectModel::loadProjectsFromVariant(const QVariant &variantProjects) {
    //qDebug() << "Вызов loadProjectsFromVariant";

    clear();  // очищаем старые проекты

    QVariantList projectList = variantProjects.toList();
    beginResetModel();
    for (const QVariant &var : projectList) {
        QVariantMap map = var.toMap();
        Project project;
        project.setProjectId(map.value("id").toInt());
        project.setProjectName(map.value("name").toString());
        project.setProjectStatus(map.value("status").toString());
        project.setProjectNotes(map.value("notes").toString());
        m_projects.append(project);
        qDebug() << "QVariantMap:" << map;
    }

    endResetModel();
}

void ProjectModel::updateProject(const Project &project) {
    for (int i = 0; i < m_projects.size(); ++i) {
        if (m_projects[i].getProjectId() == project.getProjectId()) {
            m_projects[i] = project;

            QModelIndex index = createIndex(i, 0);
            emit dataChanged(index, index, {IdRole, NameRole, StatusRole, NotesRole});
            qDebug() << "Проект обновлён в модели: ID" << project.getProjectId();
            return;
        }
    }
    qDebug() << "Проект с ID" << project.getProjectId() << "не найден для обновления.";
}
