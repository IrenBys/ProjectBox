#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>


class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(const QString& dbPath, QObject *parent = nullptr);
    ~DatabaseManager();

    QSqlDatabase& getDatabase(); // Передает соединение с БД

private:
    QSqlDatabase db;
    bool initializeDatabase();
};

#endif // DATABASEMANAGER_H
