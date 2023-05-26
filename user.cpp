#include "user.h"

const QString &User::getName() const
{
    return name;
}

void User::setName(const QString &newName)
{
    name = newName;
}

User *User::instance()
{
    static User pUser;
    return &pUser;
}

bool User::validate(const QString &_password)
{
    return validate(name, _password);
}

bool User::validate(const QString &_name, const QString &_password)
{
    //request to the server/call vmd-cli-client?
    return false;
}
