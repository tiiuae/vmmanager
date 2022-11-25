#include "rootcontext.h"
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <QDebug>

RootContext::RootContext()
{   
    //exec lsvm command
//    execCommand("lsvm");
    //parse the execution result and add to the model

    mVMDataModel.addData(Parameter("VM1", "runnig"));
    mVMDataModel.addData(Parameter("VM2", "off"));
    mVMDataModel.addData(Parameter("VM3", "off"));
}

QString RootContext::execCommand(const char *cmd)
{
    QString result;
    result = QString::fromStdString(exec(cmd));
    qDebug() << result;
    return result;
}

std::string RootContext::exec(const char* cmd)
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
    return result;
}
