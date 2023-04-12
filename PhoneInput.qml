import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    property alias phoneNumber: numberInput2.displayText //readonly?

    signal accepted()

    width: 240
    height: 40

    Row {
        spacing: Constants.spacing
        width: parent.width
        height: parent.height

        TextField {
            id: numberInput

            width: 65
            height: 30
            color: Constants.textColor1

            text: "+358"
            readOnly: true

            background: Rectangle {
                anchors.fill: parent
                color: Constants.backgroundColor3
            }
        }

        TextField {
            id: numberInput2

            width: 170
            height: 30
            color: Constants.textColor1

            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 9

            background: Rectangle {
                anchors.fill: parent
                color: Constants.backgroundColor3
            }

            onAccepted: {
                accepted()
            }
        }
    }
}
