import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root

    property string vmName: ""
    property string vmStatus: ""
    property bool hovered: false
    property int startHeight: 120
    property int completeHeight: 150

    QtObject {
        id: internal
        property bool powerOn: vmStatus === "running"
    }

    visible: opacity != 0
    color: Constants.backgroundColor2

    Row {
        anchors.centerIn: parent
        spacing: Constants.spacing

        ActionButton {
            image: "/pic/power"
//            onClicked: rootContext.switchPower(!internal.powerOn, vmName) + rootContext.update() ?
        }
        ActionButton {
            image: "/pic/settings"
            visible: internal.powerOn
            onClicked: {
                var component = Qt.createComponent("DetailsView.qml")
                if (component.status === Component.Ready) {
                    var detailsView = component.createObject(root)
                    detailsView.nameField = vmName
                    detailsView.statusField = vmStatus
                    detailsView.show()
                }
            }
        }
    }

    states: [
        State {
            when: !hovered &&!internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.8
                height: startHeight
            }
        },
        State {
            when: hovered && !internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.8
                height: completeHeight
            }
        },
        State {
            when: hovered && internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.8
                height: completeHeight
            }
        },
        State {
            when: !hovered && internal.powerOn;
            PropertyChanges {
                target: root
                opacity: 0.0
                height: startHeight
            }
        }
    ]
    transitions: Transition {
            NumberAnimation { property: "opacity"; duration: 500}
            NumberAnimation { property: "height"; duration: 500}
        }

}
