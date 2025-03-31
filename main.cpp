#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "DatabaseWorker.h"
#include "Project.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Project project;
    DatabaseWorker dbWorker;

    engine.rootContext()->setContextProperty("projectModel", &project);
    engine.rootContext()->setContextProperty("databaseWorker", &dbWorker);



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
