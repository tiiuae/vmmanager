#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>

/*
 * Getter for VM data sent by TCP/DBUS or other ways. It is empty now.
*/

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QObject *parent = nullptr);

signals:

};

#endif // DATASOURCE_H
