import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root

    property string nameField: ""
    property string statusField: "off"

    minimumHeight: 300
    minimumWidth: row.width + Constants.baseMargin*2

    color: Constants.backgroundColor0

    Label {
        id: nameLabel

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 5
        text: "VM name: " + nameField
    }

    Label {
        id: statusLabel

        anchors.top: nameLabel.bottom
        anchors.left: parent.left
        anchors.margins: 5
        text: "VM status: " + statusField
    }

    Label {
        id: timeLabel

        anchors.top: statusLabel.bottom
        anchors.left: parent.left
        anchors.margins: 5
        text: "VM runnig time: 00:30"
    }

    Row {
        id: row

        anchors.top: timeLabel.bottom
        anchors.left: parent.left
        anchors.margins: 5
        spacing: 10


        InfoTileItem {
            text: "Memory used: 150MB"
            value: 0.3
        }
        InfoTileItem {
            text: "CPU usage: 10%"
            value: 0.1
        }
        InfoTileItem {
            text: "Network load: 40%"
            value: 0.4
        }
    }

    PowerSwitcher {
        id: onOffSwitch

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 3

        powerOn: statusField === "running"
        borderColor: "black"

        onPowerChanged: rootContext.switchPower(powerOn, nameField)
    }
}
