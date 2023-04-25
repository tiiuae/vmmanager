import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    Button {
        id: closeButton

        width:  Constants.secondaryHeaderHeight
        height:  Constants.secondaryHeaderHeight

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Constants.baseMargin

        contentItem: ToolButtonContentItem {
            anchors.fill: parent
            control: parent
            image: "/pic/close"
            baseColor: Constants.backgroundColor2
            pressColor: Constants.textColor0
        }

        background: ToolButtonBackground {
            anchors.fill: parent
            control: parent
            color: Constants.backgroundColor2
        }

        onClicked: rootContext.mainViewRequiested()
    }

    Rectangle {
        id: ghafLabel

        width: 120
        height: width
        anchors.margins: Constants.baseMargin
        anchors.top: parent.top
        anchors.left: parent.left

        color: Constants.backgroundColor1

        Image {
            id: ghafImage

            anchors.centerIn: parent
            source: "/pic/ghaf-sign"
        }
    }

    ColumnLayout {
        id: infoArea

        anchors.top: ghafLabel.bottom
        anchors.left: parent.left
        anchors.margins: Constants.baseMargin * 4
        spacing: Constants.spacing

        Label {
            id: infoSectionlabel

            text: "Information"
            font {
                bold: true
                //            pixelSize: Constants.mainFontSize
            }
        }

        Row {
            id: row

            spacing: 50

            InfoTileItem {
                text: "Memory used: 150MB"
                value: 0.3
            }
            InfoTileItem {
                text: "CPU usage: 10%"
                value: 0.1
            }
            InfoTileItem {
                text: "Network load: 40%"
                value: 0.4
            }
        }

        Separator {}

        Separator {}

    }
}
