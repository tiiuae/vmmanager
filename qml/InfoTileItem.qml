import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root

    property alias text: label.text
    property alias value: progressBar.value

    width: progressBar.width
    height: progressBar.height + label.height + Constants.baseMargin*3

//    border {
//        width: 2
//        color: Constants.backgroundColor1
//    }

    color: Constants.backgroundColor0

    Label {
        id: label

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
    }

    ProgressBarM {
        id: progressBar

        anchors.top: label.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
    }

//    ProgressCircle {
//        id: progressCircle

//        anchors.top: label.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.margins: 5

//        lineWidth: 10
//        size: 150
//        secondaryColor: Constants.backgroundColor1
//        primaryColor: Constants.iconBackground
//    }
}
