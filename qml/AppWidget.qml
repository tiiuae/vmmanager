import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    x: Screen.desktopAvailableWidth - width
    y: 0 //Screen.desktopAvailableHeight - height

    width: Constants.widgetWidth
    height: Constants.widgetHeight + closeButton.height
    flags: Qt.FramelessWindowHint | Qt.CoverWindow
    color: "transparent"

    signal clicked()

    Button {
        id: closeButton

        width: 25
        height: 25
        anchors.right: background.right
        anchors.bottom: background.top
        opacity: hovered ? 1.0 : 0.0

        contentItem: ToolButtonContentItem {
            anchors.fill: parent
            control: parent
            image: "/pic/close"
        }

        background: Rectangle {
            anchors.fill: parent
            color: Constants.alphaColor(Constants.widgetBackgroundColor, 0.7)
            radius: 2
        }

        onClicked: Qt.quit()
    }

    Rectangle {
        id: background

        x: parent.x
        y: closeButton.height

        width: parent.width
        height: Constants.widgetHeight
        radius: 5
        color: Constants.alphaColor(Constants.widgetBackgroundColor, 0.9)

        GridView {
            id: grid

            anchors.fill: parent
            anchors.margins: 10

            implicitWidth: Constants.widgetWidth - 20
            width: implicitWidth
            //the max size is not defined!
            implicitHeight: Constants.widgetHeight - 20
            height: implicitHeight

            cellWidth: Constants.widgetWidth/3 - 10
            cellHeight: Constants.widgetHeight - 20
            clip: true

            model: VMDataModel

            delegate: Rectangle {
                id: delegateItem

                color: "transparent"
//                border {
//                    color: "red"
//                    width: 1
//                }

                width: grid.cellWidth
                height: grid.cellHeight

                Rectangle {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    color: Constants.widgetContentColor
                    height: delegateItem.height*0.9
                    width: 1
                    visible: index !== (grid.count - 1)
                }

                Column {
                    anchors.fill: parent
                    spacing: 5

                    SafetyIndicator {
                        id: safetyIndicator
                        anchors.right: parent.right
                        anchors.margins: 10
                        status: status
                        //width: 20
                        color: Constants.widgetContentColor
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: Constants.widgetContentColor
                        height: 1
                        width: delegateItem.width*0.9
                    }

                    Label {
                        text: name
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: Constants.widgetContentColor
                        font.pixelSize: 16
                        font.bold: true
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: background
        hoverEnabled: true

        onClicked: {
            root.clicked()
        }
    }
}
