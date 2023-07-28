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

        width: parent.width
        anchors.top: ghafLabel.bottom
        anchors.left: parent.left
        anchors.margins: Constants.baseMargin * 4
        spacing: Constants.spacing

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


        Item {

            width: infoArea.width
            height: 45

            Separator {//must be under tabbar
                anchors.bottom: bar.bottom
            }

            TabBar {
                id: bar

                contentWidth: infoArea.width
                contentHeight: 40

                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                TabButtonM {
                    text: qsTr("Software update")
                    bottomLineVisible: bar.currentIndex == TabBar.index
                }
                TabButtonM {
                    text: qsTr("Backup")
                    bottomLineVisible: bar.currentIndex == TabBar.index
                }
                TabButtonM {
                    text: qsTr("Reset")
                    bottomLineVisible: bar.currentIndex == TabBar.index
                }
                TabButtonM {
                    text: qsTr("Provisioning")
                    bottomLineVisible: bar.currentIndex == TabBar.index
                }
                TabButtonM {
                    text: qsTr("System status")
                    bottomLineVisible: bar.currentIndex == TabBar.index
                }
            }

            StackLayout {
                id: actionsView

                anchors.top: bar.bottom
                anchors.margins: Constants.baseMargin
                width: infoArea.width

                currentIndex: bar.currentIndex

                Item {
                    id: page1

                    width: parent.width

                    Column {
                        width: parent.width

                        Button {
                            width: 100
                            height: 35
                            text: qsTr("Update")
                            icon.source: "/pic/update"

                            background: ToolButtonBackground {
                                anchors.fill: parent
                                control: parent
                            }
                        }
                        Button {
                            width: 150
                            height: 35
                            text: qsTr("Version: 0.9")
                            icon.source: "/pic/settings"

                            background: ToolButtonBackground {
                                anchors.fill: parent
                                control: parent
                            }
                        }
                    }
                }

                Item {
                    id: page2

                    width: parent.width

                    Button {
                        width: 120
                        height: 35
                        text: "Placeholder"
                        icon.source: "/pic/settings"

                        background: ToolButtonBackground {
                            anchors.fill: parent
                            control: parent
                        }
                    }

                }

                Item {
                    id: page3

                    width: parent.width
                }

                Item {
                    id: page4

                    width: parent.width
                }

                Item {
                    id: page5

                    width: parent.width
                }
            }
        }
    }

}
