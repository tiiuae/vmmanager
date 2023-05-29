#ifndef ROOTCONTEXT_H
#define ROOTCONTEXT_H

#include <QObject>
#include "datasource.h"

class EnumClass : public QObject
{
    Q_GADGET

public:
    enum Views
    {
        MainVMView = 0,
        DetailsView ,
        GeneralSettings,
        LoginView,
        LoginPhoneView ,
        LoginPinView
    };
    Q_ENUM(Views)

private://to avoid instantiation
    explicit EnumClass() : QObject() {}
};

//for convinience
typedef EnumClass::Views Views;

class RootContext : public QObject
{
    Q_OBJECT

public:
    RootContext();

    VMDataModel * getVMDataModel() { return dataSource.getVMDataModel(); }

    Q_INVOKABLE void mainViewRequiested();
    Q_INVOKABLE void settingsRequiested();
    Q_INVOKABLE void loginRequest(const QString &passwd);
    Q_INVOKABLE void pinRequest(const QString &number, bool keepLogged = true);
    Q_INVOKABLE void pinSubmit(const QString &code);
    Q_INVOKABLE void detailsRequested();
    Q_INVOKABLE void updateModel();
    Q_INVOKABLE void switchPower(bool on, QString name);
    Q_INVOKABLE void saveSettings(/*???*/);

    Q_PROPERTY(int currentPage READ getCurrentPage NOTIFY currentViewChanged)
    int getCurrentPage() {return m_currentView;};

signals:
    void currentViewChanged();
    void pinResult(bool value);

private:
    int m_currentView = Views::MainVMView;
    int requestedView = Views::MainVMView;
    DataSource dataSource;
};

#endif // ROOTCONTEXT_H
