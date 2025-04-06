#include "DatabaseWorker.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QThread>


DatabaseWorker::DatabaseWorker(QObject *parent) : QObject(parent)
{
    qDebug() << "DatabaseWorker создан в потоке" << QThread::currentThread();
}

DatabaseWorker::~DatabaseWorker()
{
     qDebug() << "DatabaseWorker уничтожен в потоке:" << QThread::currentThread();
}

void DatabaseWorker::addProject(const Project &project)
{
    // Подготовка SQL-запроса для добавления проекта в базу данных
    QSqlQuery query;
    query.prepare("INSERT INTO projects(name, status) VALUES (:name, :status)");
    query.bindValue(":name", project.getProjectName());
    query.bindValue(":status", project.getProjectStatus());


    if(!query.exec())
    {
        qDebug() << "Ошибка при добавлении проекта" << query.lastError().text();
    } else {
        qDebug() << "Проект успешно добавлен.";
    }
}

QList<Project> DatabaseWorker::getProjects()
{
    // Создаём пустой список, в который мы будем складывать все загруженные из базы проекты.
    QList<Project> projects;
    // Создаем запрос на извлечение из таблицы
    QSqlQuery query("SELECT name, status FROM projects");

    if(!query.exec())
    {
        qDebug() << "Ошибка при получении проектов: " << query.lastError().text();
        return projects; // возвращаем пустой список, чтобы не крашить приложение
    }

    //Начинаем обход результатов запроса
    while(query.next())
    {
        QString name = query.value(0).toString();
        QString status = query.value(1).toString();

        Project project;
        project.setProjectName(name);
        project.setProjectStatus(status);

        projects.append(project);
    }

    return projects;
}
