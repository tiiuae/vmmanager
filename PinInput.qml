import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    width: 240
    height: 40

    property string pin:  {
        return (pinDigit1.displayText + pinDigit2.displayText
                + pinDigit3.displayText + pinDigit4.displayText)
    }

    signal accepted()//?

    Row {
        spacing: Constants.spacing*3
        anchors.centerIn: parent

        TextField {
            id: pinDigit1

            width: 40
            height: width
            color: Constants.textColor1

            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 1

            background: Rectangle {
                anchors.fill: parent
                color: Constants.backgroundColor3
            }
        }

        TextField {
            id: pinDigit2

            width: 40
            height: width
            color: Constants.textColor1

            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 1

            background: Rectangle {
                anchors.fill: parent
                color: Constants.backgroundColor3
            }
        }

        TextField {
            id: pinDigit3

            width: 40
            height: width
            color: Constants.textColor1

            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 1

            background: Rectangle {
                anchors.fill: parent
                color: Constants.backgroundColor3
            }
        }

        TextField {
            id: pinDigit4

            width: 40
            height: width
            color: Constants.textColor1

            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 1

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
