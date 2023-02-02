import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root

    property string vmName: ""
    property string vmStatus: ""
    property bool stateVisible: false
    property int startHeight: 120
    property int completeHeight: 150

    visible: opacity != 0
    color: Constants.backgroundColor2

    Row {
        anchors.centerIn: parent
        spacing: Constants.spacing

        ActionButton {
            image: "/pic/power"
            onClicked: rootContext.switchPower(false, vmName)
        }
        ActionButton {
            image: "/pic/settings"
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
            when: stateVisible;
            PropertyChanges {
                target: root
                opacity: 0.8
                height: completeHeight
            }
        },
        State {
            when: !stateVisible;
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
