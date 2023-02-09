import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    property QtObject control: null
    property alias image: contentImage.source
    property color contentColor0: Constants.backgroundColor2
    property color contentColor1: Constants.textColor0

    ColoredImage {
        id: contentImage

        anchors.centerIn: parent
    }

    states: [
        State {
            name: "normal"
            when: control.enabled && !control.pressed
            PropertyChanges {
                target: contentImage
                color: contentColor0
            }
        },
        State {
            name: "pressed"
            when: control.enabled && control.pressed
            PropertyChanges {
                target: contentImage
                color: contentColor1
            }
        }
    ]
}
