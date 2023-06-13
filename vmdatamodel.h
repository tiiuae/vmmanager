#ifndef VMDATAMODEL_H
#define VMDATAMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QModelIndex>
#include <QList>

class Parameter
{
public:
    Parameter(const QString &id, const QString &name, const QString &value)
        : m_id(id), m_name(name), m_status(value) {};

    QString id() const { return m_id; }
    QString name() const { return m_name; };
    QString status() const { return m_status; };

    void setName(const QString &newName) { m_name = newName; }

    void setStatus(const QString &newValue) { m_status = newValue; }//add validation!

    friend bool operator==(const Parameter &lhs, const Parameter &rhs);

private:
    QString m_id;
    QString m_name;
    QString m_status;
};

class VMDataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum DataRoles {
        NameRole = Qt::UserRole + 1,
        StatusRole,
        CPURole,
        MemoryRole,
        NetworkRole
    };

    VMDataModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const;
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);
    Qt::ItemFlags flags(const QModelIndex &index) const;


    void addData(const Parameter &Parameter);
    void clear();

private:
   QList<Parameter> parameters;
};

#endif // VMDATAMODEL_H
