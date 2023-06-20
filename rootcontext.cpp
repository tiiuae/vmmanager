#include "rootcontext.h"
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <QDebug>
#include "user.h"

RootContext::RootContext()
{
}

void RootContext::mainViewRequiested()
{
    m_currentView = Views::MainVMView;
    emit currentViewChanged();
}

void RootContext::detailsRequested()
{
    m_currentView = Views::DetailsView;
    emit currentViewChanged();
}

void RootContext::settingsRequiested()
{
    if (User::instance()->isLoggedIn())
        m_currentView = Views::GeneralSettings;
    else
    {
        requestedView = Views::GeneralSettings;
        if (User::instance()->hasName())
            m_currentView = Views::LoginView;

        else
            m_currentView = Views::LoginPhoneView;
    }

    emit currentViewChanged();
}

void RootContext::loginRequest(const QString &passwd)
{
    if (User::instance()->validate(passwd))
    {
        m_currentView = requestedView;
        emit currentViewChanged();
    }
    //else
}

void RootContext::pinRequest(const QString &number, bool keepLogged)
{
    if (keepLogged) {
        User::instance()->setName(number);
    }

    m_currentView = Views::LoginPinView;
    dataSource.pinRequest(number);//TODO: where must be this method: data source or user class?
    emit currentViewChanged();
//        emit pinResult(false);
}

void RootContext::pinSubmit(const QString &code)
{
    dataSource.pinSubmit(code);
    //if succesfull - get the requrested view
    m_currentView = requestedView;
    emit currentViewChanged();
//        emit pinResult(false);
}

void RootContext::updateModel()
{
    dataSource.updateModel();
}

void RootContext::switchPower(bool on, QString name)
{
    qDebug() << on << name;

    dataSource.switchPower(on, name);
}

void RootContext::saveSettings()
{
    dataSource.saveSettings();
}

void RootContext::setVmdDir(const QString &newDir)
{
    dataSource.setVmdDir(newDir);
}

