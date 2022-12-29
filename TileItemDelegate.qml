import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

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

        LinearGradient {
            id: backgroundGradient

            anchors.fill: backgroundRect
            start: Qt.point(0, 0)//backgroundRect.width/5, backgroundRect.height/5)
            end: Qt.point(backgroundRect.width, backgroundRect.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: Constants.baseColor0 }
                GradientStop { position: 1.0; color: Constants.baseColor1 }
            }
        }
    }

    PowerSwitcher {
        id: onOffSwitch

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 3
        powerOn: vmStatus === "running"
        onPowerChanged: rootContext.switchPower(powerOn, vmName)
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
                target: backgroundGradient
                visible: false
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
                target: backgroundGradient
                visible: true
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

