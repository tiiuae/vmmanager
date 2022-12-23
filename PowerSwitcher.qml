import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    property alias powerOn: control.checked
    property color borderColor: "white"

    signal powerChanged()

    width: 50
    height: 22

    Switch {
        id: control

        anchors.fill: parent
        leftPadding: 0

        onClicked: powerChanged()

        indicator: Rectangle {
                id: path
                implicitWidth: root.width
                implicitHeight: root.height
                x: 0
                y: root.height / 2 - height / 2
                radius: 0
                color: control.checked ? Constants.indicatorOn : Constants.indicatorOff
                border.color: borderColor
                border.width: 1

                Rectangle {
                    x: control.checked ? root.width - width - path.border.width : path.border.width
                    y: root.height / 2 - height / 2
                    width: 35
                    height: root.height - path.border.width*2
                    radius: 0
                    color: Constants.backgroundColor0
                    border.color: control.down ? "black" : "transparent"
                    border.width: 1

                    Text {
                        anchors.fill: parent
                        anchors.margins: 2
                        text: control.checked? "On" : "Off"
                        color: Constants.textColor1
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
    }
}
