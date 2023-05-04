import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: root

    width: 40
    height: width
    color: Constants.textColor1

    inputMethodHints: Qt.ImhDigitsOnly
    maximumLength: 1
    horizontalAlignment: Qt.AlignHCenter
    font.pixelSize: Constants.pinFontSize

    background: Rectangle {
        anchors.fill: parent
        color: Constants.backgroundColor3
        border {
            width: root.activeFocus ? 1 : 0
            color: Constants.backgroundColor2
        }
    }

    cursorDelegate: Item {}//to hide cursor/caret
}
