import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    property alias vmName: menu.vmName
    property alias vmStatus: menu.vmStatus

    width: 200
    height: 150

    Rectangle {
        id: appStatusItem

        width: parent.width
        height: 120

        anchors.top: parent.top

        color: Constants.backgroundColor1

        ColoredImage {
            id: safetyIcon

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: Constants.spacing

            source: "/pic/shield"
            color: Constants.iconBackground
        }

        Image {
            id: appIcon

            anchors.centerIn: parent

            //! TODO: size changing when mouse.hovered

            source: "/pic/filler"//should be app's icon
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

