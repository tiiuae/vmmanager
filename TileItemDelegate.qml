import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: root

    property alias vmName: menu.vmName
    property alias vmStatus: menu.vmStatus

    width: 200
    height: 150

    Rectangle {
        id: appStatusItem//appIcon

        width: parent.width
        height: 120

        anchors.top: parent.top

        color: Constants.backgroundColor1

        Image {
            id: safetyIcon

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: Constants.spacing

            source: "/pic/shield"
            visible: false
        }

        ColorOverlay {
            anchors.fill: safetyIcon
            source: safetyIcon
            color: Constants.iconBackground
        }
    }

    TileMenu {
        id: menu

        anchors.top: parent.top
        width: parent.width
        startHeight: appStatusItem.height
        completeHeight: root.height
        hovered: mouse.hovered
    }

    Label {
        id: nameLabel

        text: vmName + " " + vmStatus
        anchors.top: appStatusItem.bottom
        anchors.horizontalCenter: appStatusItem.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.margins: 5
        width: appStatusItem.width
        height: 25
        font.pixelSize: 18
        color: mouse.hovered ? Constants.textColor0 : Constants.textColor1
    }

    HoverHandler {
        id: mouse
    }
}

