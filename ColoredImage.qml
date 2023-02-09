import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: root

    property alias source: image.source
    property alias color: overlay.color

    width: image.width
    height: image.height

    Image {
        id: image

        anchors.margins: Constants.spacing
        visible: false
//        fillMode: Qt.KeepAspectRatio
    }

    ColorOverlay {
        id: overlay

        anchors.fill: image
        source: image
    }
}
