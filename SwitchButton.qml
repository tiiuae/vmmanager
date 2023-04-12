import QtQuick 2.15
import QtQuick.Controls 2.15

Switch {
    id: control

    indicator: Rectangle {
        implicitWidth: 50
        implicitHeight: 30
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: control.checked ? Constants.backgroundColor2 : Constants.backgroundColor3

        Rectangle {
            x: control.checked ? parent.width - width - 2 : 2
            y: (parent.height - height) / 2
            width: 26
            height: 26
            radius: 13
            color: control.down ? Constants.iconBackground : Constants.textColor0
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: Constants.textColor1
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
