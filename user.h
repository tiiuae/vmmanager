#ifndef USER_H
#define USER_H
#include <QString>

class User
{
private:
    User() = default;
    ~User() = default;

    bool loggedIn = false;
    QString name;

public:
    static User* instance();

    //no copy
    User(User &other) = delete;
    //no assign
    void operator=(const User &) = delete;

    const QString &getName() const;
    void setName(const QString &newName);

    bool isLoggedIn() { return loggedIn; };
    bool hasName() { return !name.isEmpty(); }
    bool validate(const QString & _password);
    bool validate(const QString & _name, const QString & _password);
};

#endif // USER_H
