import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    width: 240
    height: 100

    Image {
        id: imageItem

        width: 40
        height: 40
        source: "/pic/lock"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: Constants.baseMargin
    }

    TextField {
        id: passwordInput

        width: parent.width
        height: 30
        echoMode: TextInput.Password
        clip: true

        color: Constants.textColor1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: Constants.baseMargin

        background: Rectangle {
            anchors.fill: parent
            color: Constants.textInputBackground
        }

        onAccepted: {
            rootContext.loginRequest(text);
        }

        //+login button?
    }
}
