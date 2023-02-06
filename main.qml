import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    width: 800
    height: 600
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window

    header: ToolBar {
        id: toolBar

        height: 50

        Item {//frameless window cannot be moved!
            id: _dragHandler

            anchors.fill: parent
            DragHandler {
                acceptedDevices: PointerDevice.GenericPointer
                grabPermissions:  PointerHandler.CanTakeOverFromItems | PointerHandler.CanTakeOverFromHandlersOfDifferentType | PointerHandler.ApprovesTakeOverByAnything
                onActiveChanged: if (active) root.startSystemMove()
            }
        }

        Label {
            id: vmLabel
            text: "Virtual Machines"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.margins: Constants.baseMargin
            color: Constants.textColor0
        }

        Label {
            id: ghafLabel
            text: "GHAF"
            anchors.centerIn: parent
            color: Constants.textColor0
        }

        ToolButton {
            id: menuButton

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: closeButton.left
            height: parent.height
            width: 50

            contentItem: ToolButtonContentItem {
                anchors.fill: parent
                control: parent
                text: qsTr("⋮")
            }

            background: ToolButtonBackground {
                anchors.fill: parent
                control: parent
            }

            onClicked: generalMenu.open()
        }

        ToolButton {
            id: closeButton

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: parent.height
            width: 50

            contentItem: ToolButtonContentItem {
                anchors.fill: parent
                control: parent
                image: "/pic/close"
            }

            background: ToolButtonBackground {
                anchors.fill: parent
                control: parent
            }

            onClicked: Qt.quit()
        }

        background: Rectangle {
            anchors.fill: parent
            color: Constants.barColor
        }
    }

    GeneralMenu {
        id: generalMenu

        x: menuButton.x + menuButton.width/2 - getPointerX()
        y: toolBar.y + toolBar.height
        width: 200

        Action {
            text: "Settings"
        }

        Action {
            text: "Update view"
            shortcut: "Ctrl+R"
            onTriggered: rootContext.updateModel()
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: Constants.backgroundColor0
    }

    //view
    GridView {
        id: grid

        anchors.fill: parent
        anchors.margins: Constants.baseMargin

        cellHeight: 160
        cellWidth: 220


        model: VMDataModel
        delegate: TileItemDelegate {
            vmName: name
            vmStatus: status
        }
    }
}
