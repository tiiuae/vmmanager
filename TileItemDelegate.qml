import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root

    property string vmName: ""
    property string vmStatus: ""

    width: 200
    height: 120
    color: Constants.baseColor0

    Rectangle {
        id: indicator

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 5
        width: 15
        height: width
        radius: height/2
        color: vmStatus == "runnig" ? "#35CE8D" : "#AE4634"
    }

    Label {
        id: nameLabel

        text: vmName
        anchors.centerIn: parent
        anchors.margins: 5
        font.pixelSize: 18
        color: Constants.textColor1
    }

    Label {
        id: statusLabel

        text: vmStatus
        anchors.top: nameLabel.bottom
        anchors.horizontalCenter: nameLabel.horizontalCenter
        anchors.margins: 5
        font.pixelSize: 12
        color: Constants.textColor1
    }
}
