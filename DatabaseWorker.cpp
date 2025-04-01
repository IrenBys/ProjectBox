#include "DatabaseWorker.h"
#include <QSqlQuery>
#include <QSqlError>


DatabaseWorker::DatabaseWorker(QObject *parent)
{

}

DatabaseWorker::~DatabaseWorker()
{

}

void DatabaseWorker::addProject(const Project &project)
{
    // Подготовка SQL-запроса для добавления проекта в базу данных
    QSqlQuery query;
    query.prepare("INSERT INTO projects(name, status) VALUES (:name, :status)");
    query.bindValue(":name", project.getProjectName());
    query.bindValue(":status", project.getProjectStatus());


    if(!query.exec()) {
        qDebug() << "Ошибка при добавлении проекта" << query.lastError().text();
    } else {
        qDebug() << "Проект успешно добавлен.";
    }
}

QList<Project> DatabaseWorker::getProjects()
{
    QList<Project> projects;

}
