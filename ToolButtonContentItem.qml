import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: root

    property QtObject control: null
    property string text: ""
    property string image: ""

    QtObject {
        id: internal

        property color contentColor: Constants.textColor0
    }

    Label {
        anchors.centerIn: parent
        text: root.text
        color: internal.contentColor
        visible: text != ""
    }

    Image {
        id: contentImage

        anchors.centerIn: parent
        source: root.image
        visible: false
    }

    ColorOverlay {
        anchors.fill: contentImage
        source: contentImage
        color: internal.contentColor
        visible: image != ""
    }

    states: [
        State {
            name: "normal"
            when: control.enabled && !control.pressed
            PropertyChanges {
                target: internal
                contentColor: Constants.textColor0
            }
        },
        State {
            name: "pressed"
            when: control.enabled && control.pressed
            PropertyChanges {
                target: internal
                contentColor: Constants.backgroundColor2
            }
        }
    ]
}
