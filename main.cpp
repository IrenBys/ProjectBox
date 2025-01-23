#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "DatabaseManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Регистрируем DatabaseManager как Singleton для QML
    qmlRegisterSingletonInstance<DatabaseManager>("com.example.Database", 1, 0, "DatabaseManager", new DatabaseManager);


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
