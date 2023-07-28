import QtQuick 2.15
import QtGraphicalEffects 1.15

Image {
    id: root

    property alias color: overlay.color

    ColorOverlay {//beware the borders!
        id: overlay

        anchors.fill: parent
        source: parent
    }
}
