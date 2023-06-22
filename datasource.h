#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>
#include <QTimer>
#include "vmdatamodel.h"
#include "user.h"

enum class Commands
{
    List = 0,
    Info,
    Action
};

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

    void setVmdDir(const QString &newVmdDir);

public slots:
    Q_INVOKABLE void updateModel();
    void fillInTheModelSlot(QStringList list);
    void fillInTheModelItemInfoSlot(QByteArray info);

signals:
    void listReady(QStringList list);
    void infoReady(QByteArray info);

private:
    QTimer updateModelTimer;
    VMDataModel mVMDataModel;
    QString vmdDir;

    void runCLI(Commands cmd, QStringList args = QStringList());
};

#endif // DATASOURCE_H
