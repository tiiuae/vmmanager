import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root

    property string vmName: ""
    property string vmStatus: ""

    width: 200
    height: 120
    background: Rectangle {
        id: backgroundRect

        anchors.fill: parent
        color: Constants.baseColor0
    }

    Rectangle {
        id: indicator

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 5
        width: 15
        height: width
        radius: height/2
        color: vmStatus == "runnig" ? Constants.indicatorOn : Constants.indicatorOff
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

    states: [
        State {
            name: "normal"
            when: !root.pressed && root.enabled
            PropertyChanges {
                target: backgroundRect
                color: Constants.baseColor0
            }
            PropertyChanges {
                target: statusLabel
                color: Constants.textColor1
            }
            PropertyChanges {
                target: nameLabel
                color: Constants.textColor1
            }
        },
        State {
            name: "pressed"
            when: root.pressed && root.enabled
            PropertyChanges {
                target: backgroundRect
                color: Constants.baseColor1
            }
            PropertyChanges {
                target: statusLabel
                color: Constants.textColor0
            }
            PropertyChanges {
                target: nameLabel
                color: Constants.textColor0
            }
        }
        //+ disabled when not running?

    ]
}

