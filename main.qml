import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    width: 800
    height: 600
    visible: true
    title: qsTr("VM manager")

    header: ToolBar {
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            height: parent.height
            spacing: Constants.spacing
            ToolButton {
                text: "Update"
            }
            ToolButton {
                text: "View"
            }
            ToolButton {
                text: "Help"
            }
        }

        ToolButton {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: parent.height

            text: qsTr("⋮")
            //onClicked: menu.open()
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

        cellHeight: 140
        cellWidth: 220


        model: VMDataModel
        delegate: TileItemDelegate {
            vmName: name
            vmStatus: status

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.debug("clicked")
                    var component = Qt.createComponent("DetailsView.qml")
                    if (component.status === Component.Ready) {
                        var detailsView = component.createObject(root)
                        detailsView.nameField = name
                        detailsView.statusField = status
                        detailsView.show()
                    }
                }
            }
        }
    }
}
