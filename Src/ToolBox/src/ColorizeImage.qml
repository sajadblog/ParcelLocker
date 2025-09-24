import QtQuick
import QtQuick.Effects

Item{
    id:root
    property alias color : imageEffect.colorizationColor
    property alias source: image.source

    Image {
        id: image
        anchors.fill: parent
        visible : false
    }
    MultiEffect {
        id : imageEffect
        anchors.fill: parent
        source: image
        colorization: 1
        colorizationColor: internal.alternativeColor
    }

}
