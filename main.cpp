#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "rootcontext.h"

//! add check for another app instance?

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //register enums
    qRegisterMetaType<Views>("Views");
    qmlRegisterUncreatableType<EnumClass>("ViewEnums", 1, 0, "Views", "Not creatable as it is an enum type");

    RootContext context;
    QQmlApplicationEngine engine;

#ifdef TABLET
    const QUrl url(QStringLiteral("qrc:/tablet/main.qml"));
#else
    const QUrl url(QStringLiteral("qrc:/main.qml"));
#endif

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("rootContext", &context);
    engine.rootContext()->setContextProperty("VMDataModel", context.getVMDataModel());

    engine.load(url);

    return app.exec();
}
