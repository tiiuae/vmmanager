import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root

    property alias vmName: menu.vmName
    property alias vmStatus: menu.vmStatus
    property bool isCurrent: mouse.hovered
    property int vmSafetyStatus: 0

    width: 260
    height: 120

    color: Constants.backgroundColor0

    layer.enabled: !menu.visible
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 2
        color: Constants.shadowColor
        samples: 9
    }

    Rectangle {
        id: appArea

        width: height
        height: parent.height

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        color: Constants.backgroundColor1

        Image {
            id: appIcon

            anchors.centerIn: parent

            width: mouse.hovered? implicitWidth*1.2 : implicitWidth
            height: mouse.hovered? implicitHeight*1.2 : implicitHeight

            Behavior on height {
                NumberAnimation {duration: 200}
            }

            Behavior on width {
                NumberAnimation {duration: 200}
            }

            source: "/pic/filler"//should be app's icon
        }
    }

    Image {
        id: safetyIcon

        anchors.top: parent.top
        anchors.left: appArea.right
        anchors.margins: Constants.spacing

        source: {//add enum!
            if (vmSafetyStatus === 0) {
                return "/pic/no_risk"
            }
            if (vmSafetyStatus === 1) {
                return "/pic/medium_risk"
            }
            if (vmSafetyStatus === 2) {
                return "/pic/high_risk"
            }
        }
    }

    Label {
        id: nameLabel

        text: vmName
        anchors.left: appArea.right
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.margins: 5
        height: 25
        font.pixelSize: 18
        font.bold: true
        color: Constants.textColor1
    }

    Label {
        id: statusLabel

        text: vmStatus
        anchors.left: appArea.right
        anchors.top: nameLabel.bottom
        horizontalAlignment: Text.AlignHCenter
        anchors.margins: 5
        height: 25
        font.pixelSize: 18
        color: Constants.textColor1
    }

    Button {
        id: detailsButton

        width: 30
        height: width

        anchors.top: parent.top
        anchors.right: parent.right

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        contentItem: ButtonContentItem {
            image: "/pic/dots_h"
            anchors.fill: parent
            control: parent
        }
    }

    TileMenu {
        id: menu

        anchors.top: parent.top
        width: parent.width
        height: parent.height
        hovered: mouse.hovered
    }

    HoverHandler {
        id: mouse
    }
}

