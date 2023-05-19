import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: root

    property bool highlighted: false

    width: 40
    height: width
    color: Constants.textColor1

    inputMethodHints: Qt.ImhDigitsOnly
    maximumLength: 1
    horizontalAlignment: Qt.AlignHCenter
    font.pixelSize: Constants.pinFontSize

    background: Rectangle {
        id: backgroundRect

        anchors.fill: parent
        color: Constants.backgroundColor3
        border {
            width: root.activeFocus | highlighted ? 1 : 0
            color: highlighted? "red" : Constants.backgroundColor2
        }
    }

    cursorDelegate: Item {}//to hide cursor/caret
}
