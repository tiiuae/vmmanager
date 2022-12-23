#include "rootcontext.h"
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <QDebug>

/*
    Now there is only one way to retrieve appVM's info: using "lsvm" command,
    which provides us with names and statuses of appVM's.

    For testing purposes the test.txt file is used. This file must be in the same directiry as executable file.
*/

RootContext::RootContext()
{   
    updateModel();
}

void RootContext::updateModel()
{
    if(mVMDataModel.rowCount(QModelIndex()) > 0)
        mVMDataModel.clear();

    //exec lsvm command
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

void RootContext::powerChanged(bool on, QString name)
{
    qDebug() << on << name;

//    if (on)
//        execCommand("start vm");
//    else
//        execCommand("stop vm");
}

QString RootContext::execCommand(const char *cmd)
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
