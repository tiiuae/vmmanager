import QtQuick 2.15
import QtQuick.Controls 2.15

Menu {
    id: root

    topPadding: Constants.baseMargin
    bottomPadding: Constants.baseMargin
    //right and left ones?

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: root.count + 2*Constants.baseMargin
        color: Constants.backgroundColor1
    }

    delegate: MenuItem {
        id: menuItem

        implicitWidth: 200
        implicitHeight: 40

        contentItem: Label {
            id: textItem

            text: menuItem.text
            font: menuItem.font
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
//            opacity: enabled ? 1.0 : 0.3
            color: menuItem.highlighted ? Constants.textColor0 : Constants.textColor1
        }

        background: Rectangle {
            id: backgroundRect

            implicitWidth: 200
            implicitHeight: 40

            color: menuItem.hovered ? Constants.backgroundColor2 : Constants.backgroundColor1
        }
    }
}
