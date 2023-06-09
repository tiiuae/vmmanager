#include "datasource.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonArray>

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

    For testing purposes the test.txt file is used. This file must be in the same directory as executable file.
    The template is shown below:
    <VM_name> <status>
*/

#define RUN_CLI_LIST "cd ~/tii-projects/vmd && nix run .#packages.x86_64-linux.vmd-client -- \
--hostname localhost \
--port 8080 \
--cacert ./test/auth/certs/sample-ca-crt.pem \
--cert ./test/auth/certs/sample-vmd-client-chain.pem \
--key ./test/auth/certs/sample-vmd-client-key.pem \
--output text \
list \
"

DataSource::DataSource(QObject *parent)
    : QObject{parent}
{
    QObject::connect(&updateModelTimer, &QTimer::timeout, this, &DataSource::updateModel);
    updateModelTimer.start(UPDATE_INTERVAL);
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
    if(mVMDataModel.rowCount(QModelIndex()) > 0)
        mVMDataModel.clear();

#ifdef TEST
    QString vmInfo = execCommand("cat test.txt");
#else
    QString vmInfo = execCommand(RUN_CLI_LIST);
#endif
    vmInfo = vmInfo.trimmed();

    //parse the execution result and add to the model
    QTextStream stream (&vmInfo, QIODevice::ReadOnly);
    while(!stream.atEnd()) {
        QString temp1, temp2;
        stream >> temp1 >> temp2;
        mVMDataModel.addData(Parameter(temp1, temp2));
    }
}

void DataSource::switchPower(bool on, QString name)
{
    QString command = QString("vmd-client action") + (on? QString(" start ") : QString(" stop ")) + name;//?
    qDebug() << execCommand(command.toLocal8Bit().data());
}

void DataSource::saveSettings()
{

}


QString DataSource::execCommand(const char *cmd)
{
    qDebug() << "enter execCommand()";
    std::array<char, 128> buffer;
    std::string result;
    auto pipe = popen(cmd, "r");

    if (!pipe) throw std::runtime_error("popen() failed!");

    while (!feof(pipe)) {
        if (fgets(buffer.data(), 128, pipe) != nullptr)
            result += buffer.data();
    }

    auto rc = pclose(pipe);
    qDebug() << QString::fromStdString(result) << ", code is " << rc;

    return QString::fromStdString(result);
}

