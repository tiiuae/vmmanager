import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    property Item currentItem: null

    //way to send response!
    //command with id/name

    function startMovement() {
        console.log("vmTile x,y:" + vmTile.x + ", " + vmTile.y)
        row.opacity = 0.0
        vmTile.x = currentItem.x
        vmTile.y = currentItem.y
        appearingAnimation.start()
    }

    TileItemDelegate {
        id: vmTile

        vmName: currentItem ? currentItem.vmName : ""
        vmStatus: currentItem ? currentItem.vmStatus : ""

//        x:  currentItem ? currentItem.x : 5
//        y:  currentItem ? currentItem.y : 5
    }

    SequentialAnimation {
        id: appearingAnimation

        PropertyAnimation {
            target: vmTile
            properties: "x,y"
            to: 5
            duration: 400
        }

        PropertyAnimation {
            target: row
            property: "opacity"
            to: 1.0
            duration: 400
        }
    }

    Button {
        id: closeButton

        width: 35
        height: 35

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

    Row {
        id: row

        anchors.top: vmTile.bottom
        anchors.left: parent.left
        anchors.margins: 5
        spacing: 10
        opacity: 0.0


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

    //    Row {
    //        anchors.right: parent.right
    //        anchors.top: parent.top
    //        anchors.margins: Constants.baseMargin

    //        height: header.height
    //        spacing: Constants.spacing

    //        Button {
    //            width: 100
    //            height: 35

    //            contentItem: ToolButtonContentItem {
    //                anchors.fill: parent
    //                control: parent
    //                text: "Shutdown"
    //                baseColor: Constants.backgroundColor2
    //                pressColor: Constants.textColor0
    //            }

    //            background: ToolButtonBackground {
    //                anchors.fill: parent
    //                control: parent
    //                color: Constants.backgroundColor2
    //            }

    ////            onClicked: rootContext.switchPower()
    //        }

    //        Button {
    //            width: 100
    //            height: 35

    //            contentItem: ToolButtonContentItem {
    //                anchors.fill: parent
    //                control: parent
    //                text: "Pause"
    //                baseColor: Constants.backgroundColor2
    //                pressColor: Constants.textColor0
    //            }

    //            background: ToolButtonBackground {
    //                anchors.fill: parent
    //                control: parent
    //                color: Constants.backgroundColor2
    //            }
    //        }
    //    }
}
