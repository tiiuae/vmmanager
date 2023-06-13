import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root

    property string vmName: ""
    property string vmStatus: ""

    property bool hovered: false

    QtObject {
        id: internal
        property bool powerOn: vmStatus === "running"
    }

    visible: opacity != 0
    color: Constants.backgroundColor2

    Row {
        anchors.centerIn: parent
        spacing: Constants.smallSpacing

        ActionButton {
            image: "/pic/power"
            onClicked: rootContext.switchPower(!internal.powerOn, vmName) //+ rootContext.update() ?
        }
        ActionButton {
            image: "/pic/pause"
            visible: internal.powerOn
            //this functionality has not been discussed yet
//            onClicked: rootContext.switchPower(!internal.powerOn, vmName)// + rootContext.update() ?
        }
        ActionButton {
            image: "/pic/settings"
            visible: internal.powerOn
            onClicked: {
                rootContext.detailsRequested()
                console.log(vmName)
            }
        }
    }

    states: [
        State {
            name: "off"
            when: !internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.8
            }
        },
        State {
            name: "on"
            when: !hovered && internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.0
            }
        },
        State {
            name: "on-focused"
            when: hovered && internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.8
            }
        }
    ]

   Behavior on opacity {//transitions instead
            NumberAnimation {duration: 500;}
        }

}
