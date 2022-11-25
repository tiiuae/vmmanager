#ifndef ROOTCONTEXT_H
#define ROOTCONTEXT_H

#include <QObject>
#include "vmdatamodel.h"

class RootContext : public QObject
{
    Q_OBJECT
public:
    RootContext();

    VMDataModel * getVMDataModel() {return &mVMDataModel;}
    QString execCommand(const char * cmd);

private:
    VMDataModel mVMDataModel;
    std::string exec(const char* cmd);
};

#endif // ROOTCONTEXT_H
