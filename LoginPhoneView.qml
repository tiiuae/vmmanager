import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    property bool pinVisible: false

    Image {
        id: ghafImage

        width: 65
        height: 65
        source: "/pic/ghaf-sign"

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: Constants.baseMargin * 3
    }

    Image {
        id: ghafTextLabel

        width: 115
        height: 30
        source: "/pic/ghaf-text"

        anchors.top: ghafImage.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: Constants.baseMargin * 2
    }

    Label {
        id: tipLabel

        anchors.margins: Constants.baseMargin *5
        anchors.top: ghafTextLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Login or create account"
    }

    ColumnLayout {
        id: phoneInputLayout

        anchors.top: tipLabel.bottom
        anchors.margins: Constants.baseMargin *5
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Constants.spacing*2

        Label {
            id: tipLabel2

            text: "Enter your number below"
        }

        PhoneInput {
            id: phoneInput

            visible: !pinVisible

            onAccepted: {

            }
        }

        PinInput {
            id: pinInput

            visible: pinVisible

            onAccepted: {

            }
        }

        Label {
            id: tipLabel3

            text: "You'll recieve SMS with one-time PIN"
        }

        SwitchButton {
            text: "Keep me logged in"
            visible: !pinVisible
        }
    }

    Button {
        id: loginButton

        width: 240
        height: 30

        anchors.horizontalCenter: phoneInputLayout.horizontalCenter
        anchors.top: phoneInputLayout.bottom
        anchors.margins: Constants.baseMargin * 5

        contentItem: Label  {
            anchors.centerIn: parent
            text: "CONTINUE"
            font.bold: true
            horizontalAlignment: Qt.AlignHCenter
            color: loginButton.pressed ? Constants.textColor1 : Constants.textColor0
        }

        background: Rectangle {
            anchors.fill: parent
            color: loginButton.pressed ?  Constants.backgroundColor1 : Constants.barColor
        }

        onClicked: {
            if (pinVisible) {
                rootContext.pinSubmit(pinInput.pin)
            }
            else {
                rootContext.pinRequest(phoneInput.phoneNumber)
            }
//            pinVisible = !pinVisible//for test
        }
    }

}
