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

            text: qsTr("⋮")
            onClicked: generalMenu.open()
        }

        ToolButton {
            id: closeButton

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: parent.height

            icon.source: "/pic/close"
            onClicked: Qt.quit()
        }

        background: Rectangle {
            anchors.fill: parent
            color: Constants.barColor
        }
    }

    Menu {
        id: generalMenu

        MenuItem {
            text: "Settings"
        }
        MenuItem {
            text: "Update view"
            action: updateAction
        }

        //background

        //bug: incorrect positioning!
        //set x and y
    }

    Action {
        id: updateAction
        text: "Update"
        shortcut: "Ctrl+R"
        onTriggered: rootContext.updateModel()
        //tooltip: "Update VM info"
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
