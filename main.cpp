#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "rootcontext.h"
#include <iostream>

/*
 * The app usage:
 * vmmanager [--vmd-client-dir <directory>]
 * The application vmmanager can be run with or without vmd-client-dir argument. If no argument specified the vmd-client dir is set to current dir.
*/

//! add check for another app instance?

const QString get_option(const QList<QString>& args, const QString& option_name)
{
    for (auto it = args.begin(), end = args.end(); it != end; ++it)
    {
        if (*it == option_name)
        {
            if (it + 1 != end)
                return *(it + 1);
        }
    }

    return "";
}

bool has_option(const QList<QString>& args, const QString& option_name)
{
    for (auto it = args.begin(), end = args.end(); it != end; ++it)
    {
        if (*it == option_name)
            return true;
    }

    return false;
}

int main(int argc, char *argv[])
{
    //args handling
    const QList<QString> args(argv, argv + argc);

    QString vmd_dir = get_option(args, "--vmd-client-dir");
    if (vmd_dir.isEmpty() && argc > 1) {
        std::cout << "Wrong arguments!\nUsage: vmmanager [--vmd-client-dir] <DIRECTORY>\n<DIRECTORY> - directory where CLI client is located (temporary solution for Ubuntu)\n";
        return 1;
    }
    qDebug() << "arg: " << vmd_dir;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //register enums
    qRegisterMetaType<Views>("Views");
    qmlRegisterUncreatableType<EnumClass>("ViewEnums", 1, 0, "Views", "Not creatable as it is an enum type");

    RootContext context;
    context.setVmdDir(vmd_dir);//set dir to the CLI client and update the model
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
