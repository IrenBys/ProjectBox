#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "DatabaseManager.h"
#include "ProjectModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    DatabaseManager dbManager("projects.db");  // Путь к базе данных
    // Регистрация DatabaseManager как синглтона в QML
    qmlRegisterSingletonInstance<DatabaseManager>("com.example.Database", 1, 0, "DatabaseManager", &dbManager);

    qmlRegisterType<ProjectModel>("com.example.ProjectModel", 1, 0, "ProjectModel");


    const QUrl url(QStringLiteral("qrc:/QML/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
