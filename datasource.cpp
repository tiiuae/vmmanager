#include "datasource.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonArray>
#include <QProcess>
#include <QDir>

#define UPDATE_INTERVAL 5000

/*
    The VM info will be provided by command line util vmd-cli.

    Usage: vmd-client [OPTIONS] --hostname <HOSTNAME> --port <PORT> --cacert <CACERT> --key <KEY> --cert <CERT> --output <OUTPUT> <COMMAND>

    Commands:
      list
      info
      action
      help    Print this message or the help of the given subcommand(s)

    Options:
          --hostname <HOSTNAME>
      -p, --port <PORT>
          --cacert <CACERT>
          --key <KEY>
          --cert <CERT>
          --verbose
          --output <OUTPUT>      [possible values: json, yaml, text]
      -h, --help                 Print help
      -V, --version              Print version

    For testing purposes the test.txt file is used (#DEFINES += TEST in .pro file must uncommented).
    This file must be in the same directory as executable file. The template is shown below:
    <VM_name> <status>
*/

#define RUN_CLI "./result/bin/vmd-client"

DataSource::DataSource(QObject *parent)
    : QObject{parent}
{
    QObject::connect(&updateModelTimer, &QTimer::timeout, this, &DataSource::updateModel);
    updateModelTimer.start(UPDATE_INTERVAL);

    QObject::connect(this, &DataSource::listReady, this, &DataSource::fillInTheModelSlot);
}

//TODO: login mechanism
void DataSource::loginRequest(const QString &passwd)
{
    Q_UNUSED(passwd)
}

void DataSource::pinRequest(const QString &number)
{
    Q_UNUSED(number)
}

void DataSource::pinSubmit(const QString &code)
{
    Q_UNUSED(code)
}
///////////////////////////////////////////////////////

void DataSource::updateModel()
{
#ifdef TEST
    QString vmInfo = execCommand("cat test.txt");
    vmInfo = vmInfo.trimmed();
    //parse the execution result and add to the model
    QTextStream stream (&vmInfo, QIODevice::ReadOnly);
    while(!stream.atEnd()) {
        QString temp1, temp2;
        stream >> temp1 >> temp2;
        mVMDataModel.addData(Parameter(temp1, temp1, temp2));
    }
#else
    qDebug() << "updateModel()";
    //! get the ID's list
    runCLI(Commands::List);

#endif
}

void DataSource::fillInTheModelSlot(QStringList list)
{
    for (const QString &id: list)
    {
        //runCLI(Commands::Info, id);
        mVMDataModel.addData(Parameter(id, "vm" + id, "running"));//for testing purposes all of the VMs marked as running
    }
}

void DataSource::fillInTheModelItemInfoSlot(QByteArray info)
{
    //parse & add
    //mVMDataModel.addData(Parameter(arg, "vm" + arg, "running"));//for testing purposes all of the VMs marked as running
}

void DataSource::setVmdDir(const QString &newVmdDir)
{
    qDebug() << "setVmdDir() " << newVmdDir;
    vmdDir = newVmdDir;
    updateModel();
}

void DataSource::switchPower(bool on, QString name)
{
    runCLI(Commands::Action, QStringList() << name << (on? "start" : "stop"));
}

void DataSource::saveSettings()
{

}

void DataSource::runCLI(Commands cmd, QStringList args)
{
    QProcess * process = new QProcess(this);
    process->setReadChannel(QProcess::StandardOutput);
    process->setProcessChannelMode(QProcess::MergedChannels);

    QObject::connect(process, &QProcess::stateChanged, [process] {qDebug() << process->processId() << process->processEnvironment().toStringList() << process->state() << process->errorString();});

    if (!vmdDir.isEmpty())
        process->setWorkingDirectory(vmdDir);

    //or set the directory for the whole app
//    QDir::setCurrent(vmdDir);

    qDebug() << "runCLI in " << process->workingDirectory();

    QStringList allArgs;
    allArgs << "--hostname" << "localhost" << "--port" << "8080" << "--cacert" << "test/auth/certs/sample-ca-crt.pem" << "--cert"
         << "test/auth/certs/sample-vmd-client-chain.pem" << "--key" << "test/auth/certs/sample-vmd-client-key.pem" << "--verbose" << "--output" << "text";

    switch(cmd)
    {
    case Commands::List:
    {
        qDebug() << "List cmd";

        allArgs << "list";

        QObject::connect(process, &QProcess::readyRead, [process, this] () {
            QByteArray a = process->readAllStandardOutput();
            QStringList list = QString(a).split(QLatin1Char(','), Qt::SkipEmptyParts);
            qDebug() << "list ready" << a;
            emit listReady(list);
        });
    }
        break;
    case Commands::Info:
    {
        allArgs << "info" << args;

        QObject::connect(process, &QProcess::readyRead, [process, this] () {
            QByteArray a = process->readAllStandardOutput();
            emit infoReady(a);
        });

    }
        break;
    case Commands::Action:
    {
        allArgs << "action" << args;
    }
        break;
    }

    QObject::connect(process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
                     [=](int exitCode, QProcess::ExitStatus /*exitStatus*/){
        qDebug()<< "process exited with code " << exitCode;
        process->deleteLater();
    });

    process->start(QString(RUN_CLI), allArgs, QIODevice::ReadOnly);
    qDebug() << "ARGS: " << process->arguments() << process->workingDirectory() << process->program();
}

