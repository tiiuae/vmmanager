#include "vmdatamodel.h"

VMDataModel::VMDataModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

int VMDataModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);//table model, no parent
    return parameters.count();
}

QVariant VMDataModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= parameters.count())
        return QVariant();

    const Parameter &parameter = parameters[index.row()];
    if (role == NameRole)
        return parameter.name();
    else if (role == StatusRole)
        return parameter.status();
    return QVariant();
}


QHash<int, QByteArray> VMDataModel::VMDataModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[StatusRole] = "status";
    roles[CPURole] = "cpu_usage";
    roles[MemoryRole] = "memory_usage";
    roles[NetworkRole] = "network_usage";
    return roles;
}

bool VMDataModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (index.row() < 0 || index.row() >= parameters.count())
        return false;

    Parameter &parameter = parameters[index.row()];
    if (role == NameRole)
         parameter.setName(value.toString());
    else if (role == StatusRole)
         parameter.setStatus(value.toString());
    return true;
}

Qt::ItemFlags VMDataModel::flags(const QModelIndex &index) const
{
    Q_UNUSED(index)
    return Qt::ItemIsEnabled | Qt::ItemIsSelectable;
}

void VMDataModel::addData(const Parameter &Parameter)
{
    if (parameters.contains(Parameter))//parameters.indexOf(Parameter);
    {
        //update other fields
        return;
    }
    beginInsertRows(QModelIndex(), parameters.count(), parameters.count());
    parameters << Parameter;
    endInsertRows();
}

void VMDataModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, parameters.count());
    parameters.clear();
    endRemoveRows();
}

bool operator==(const Parameter &lhs, const Parameter &rhs)
{
    return lhs.id() == rhs.id();
}
