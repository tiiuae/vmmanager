#include "datasource.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonArray>

/*
    The VM info will be provided by command line util vmd-cli.

    For testing purposes the test.txt file is used. This file must be in the same directory as executable file.
    The template is shown below:
    <VM_name> <status>
*/

DataSource::DataSource(QObject *parent)
    : QObject{parent}
{
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

    //run vmd-client-cli --json
    QString vmInfo = execCommand("cat test.txt");
    vmInfo = vmInfo.trimmed();//simplified()?

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
    QString command = QString("vmd-client-cli ") + (on? QString(" start ") : QString(" stop ")) + name;
    qDebug() << execCommand(command.toLocal8Bit().data());
}

void DataSource::saveSettings()
{

}


QString DataSource::execCommand(const char *cmd)
{
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }

    return QString::fromStdString(result);
}

