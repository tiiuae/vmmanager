import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    QtObject {
        id: internal

        property int gridItemX: 0
        property int gridItemY: 0
        property string vmName: ""
        property string vmStatus: ""
        property int vmSafetyStatus: 0

    }

    function initialize(currentItem) {
        internal.gridItemX = currentItem.x
        internal.gridItemY = currentItem.y
        internal.vmName = currentItem.vmName
        internal.vmStatus = currentItem.vmStatus
        internal.vmSafetyStatus = currentItem.vmSafetyStatus
    }

    function startMovement() {
        console.debug("Tile x,y:" + internal.gridItemX  + ", " + internal.gridItemY)
        infoArea.opacity = 0.0
        vmTile.x = internal.gridItemX >= Constants.baseMargin ? internal.gridItemX : Constants.baseMargin
        vmTile.y = internal.gridItemY >= Constants.baseMargin ? internal.gridItemY : Constants.baseMargin
        appearingAnimation.start()
    }

    TileItem {
        id: vmTile

        vmName: internal.vmName
        vmStatus: internal.vmStatus
    }

    SequentialAnimation {
        id: appearingAnimation

        PropertyAnimation {
            target: vmTile
            properties: "x,y"
            to: Constants.baseMargin
            duration: (vmTile.x === to) && (vmTile.y === to)? 100 : 400
        }

        PropertyAnimation {
            target: infoArea
            property: "opacity"
            to: 1.0
            duration: 400
        }
    }

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

    ColumnLayout {
        id: infoArea

        anchors.top: vmTile.bottom
        anchors.left: parent.left
        anchors.margins: Constants.baseMargin * 4
        spacing: Constants.spacing
        opacity: 0.0

        Label {
            id: infoSectionlabel

            text: qsTr("Information")
            font {
                bold: true
                //            pixelSize: Constants.mainFontSize
            }
        }

        Row {
            id: row

            spacing: 50

            InfoTileItem {
                text: qsTr("Memory used: 150MB")
                value: 0.3
            }
            InfoTileItem {
                text: qsTr("CPU usage: 10%")
                value: 0.1
            }
            InfoTileItem {
                text: qsTr("Network load: 40%")
                value: 0.4
            }
        }

        Separator {}

        Row {
            Layout.preferredHeight: 40
            spacing: Constants.spacing

            SafetyIndicator {
                status: internal.vmSafetyStatus
            }

            Label {
                text: {
                    if (internal.vmSafetyStatus === 0)
                        return qsTr("No security threat!")
                    if (internal.vmSafetyStatus === 1)
                        return qsTr("Medium risk")
                    if (internal.vmSafetyStatus === 2)
                        return qsTr("High risk!")
                }
            }
        }

        Separator {}

        Row {
            Layout.preferredHeight: 40
            spacing: Constants.spacing

            Button {
                width: 100
                height: 35

                contentItem: ToolButtonContentItem {
                    anchors.fill: parent
                    control: parent
                    text: qsTr("Shutdown")
                    baseColor: Constants.backgroundColor2
                    pressColor: Constants.textColor0
                }

                background: ToolButtonBackground {
                    anchors.fill: parent
                    control: parent
                    color: Constants.backgroundColor2
                }

                onClicked: rootContext.switchPower(false, internal.vmName)
            }

            Button {
                width: 100
                height: 35

                contentItem: ToolButtonContentItem {
                    anchors.fill: parent
                    control: parent
                    text: qsTr("Pause")
                    baseColor: Constants.backgroundColor2
                    pressColor: Constants.textColor0
                }

                background: ToolButtonBackground {
                    anchors.fill: parent
                    control: parent
                    color: Constants.backgroundColor2
                }

//                onClicked: rootContext.switchPower(?) //no such functionality
            }
        }

        Separator {}
    }
}
