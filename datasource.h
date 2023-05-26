#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>
#include <QTimer>
#include "vmdatamodel.h"
#include "user.h"

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QObject *parent = nullptr);

    VMDataModel * getVMDataModel() { return &mVMDataModel; }

    Q_INVOKABLE void loginRequest(const QString &passwd);
    Q_INVOKABLE void pinRequest(const QString &number);
    Q_INVOKABLE void pinSubmit(const QString &code);
    Q_INVOKABLE void switchPower(bool on, QString name);
    Q_INVOKABLE void saveSettings(/*???*/);

public slots:
    Q_INVOKABLE void updateModel();

private:
    QTimer updateModelTimer;
    VMDataModel mVMDataModel;

    QString execCommand(const char * cmd);
};

#endif // DATASOURCE_H
