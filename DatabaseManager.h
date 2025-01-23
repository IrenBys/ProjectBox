/**
 * @class DatabaseManager
 * @brief Класс для управления базой данных приложения.
 *
 * Этот класс отвечает за создание, инициализацию и взаимодействие с базой данных,
 * включая добавление проектов и их загрузку. Класс может быть расширен для работы
 * с другими типами данных.
 */

#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>    // Управление подключением к базе данных
#include <QSqlQuery>       // Выполнение SQL-запросов
#include <QSqlError>       // Обработка ошибок базы данных
#include <QDebug>          // Для отладочных сообщений

class DatabaseManager : public QObject
{
    Q_OBJECT

public:

    explicit DatabaseManager(QObject *parent = nullptr); // Конструктор будет инициализировать базу данных
    ~DatabaseManager(); // Деструктор закроет соединение с базой данных

    Q_INVOKABLE bool addProject(const QString &projectName);    // Метод для добавления проекта
    Q_INVOKABLE QStringList getProjects();  // Mетод, который будет возвращать все проекты из базы данных

private:
    bool initializeDatebase();  // Метод для создания и настройки БД
    QSqlDatabase db;  // Экземпляр базы данных (управляет подключением к SQLite).
};

#endif // DATABASEMANAGER_H
