import QtQuick 2.15
import QtQuick.Controls 2.15

TabButton {
    id: root

    property bool bottomLineVisible: false

    width: 120
    height: 40

    contentItem: Item {
        anchors.fill: parent

        Label {
            id: textLabel
            anchors.centerIn: parent
            color: Constants.textColor1
            text: root.text
        }
    }


    background: Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: bottomLine

            anchors.bottom: parent.bottom
            width: parent.width
            height: 3
            color: Constants.iconBackground
            opacity: bottomLineVisible ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation {duration: 300;}
            }
        }
    }
}
