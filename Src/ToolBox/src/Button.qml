import QtQuick
import QtQuick.Effects

Rectangle{
    id:root
    property alias text : textItem.text
    property bool enableClickAnimation : true

    signal clicked()

    QtObject{
        id : internal
        property color mainColor : appearanceManager.backgroundColor
        property color alternativeColor : appearanceManager.primaryColor
    }

    height: appearanceManager.iconNormalSize
    width: textItem.width + 2 * appearanceManager.marginsBig
    radius: appearanceManager.radius
    border.width: 1
    border.color: internal.alternativeColor
    color : internal.mainColor
    clip: true

    Text {
        id : textItem
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: appearanceManager.fontMediumPixelSize
        opacity: enabled ? 1.0 : 0.3
        color: internal.alternativeColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    Rectangle{
        id:hoverRect
        anchors.fill: parent
        color : internal.alternativeColor
        opacity : mouseArea.containsMouse ? 0.1 : 0.0
        Behavior on opacity {PropertyAnimation{}}
    }
    Rectangle{
        id:waveRectangle
        height: 0
        width: 0
        color: internal.alternativeColor
        opacity : 0.0
        radius: height / 2
        ParallelAnimation{
            id : waveAnimator
            property int duration : 500
            property int finalSize : appearanceManager.iconNormalSize
            NumberAnimation{id: xAnimation;target: waveRectangle;property: "x";duration :waveAnimator.duration}
            NumberAnimation{id: yAnimation;target: waveRectangle; property: "y";duration :waveAnimator.duration}
            NumberAnimation{target: waveRectangle; property: "width";from : 0.0; to : waveAnimator.finalSize ; duration :waveAnimator.duration}
            NumberAnimation{target: waveRectangle; property: "height";from : 0.0; to : waveAnimator.finalSize ; duration :waveAnimator.duration}
            NumberAnimation{target: waveRectangle; property: "opacity";from : 1.0; to : 0.0 ; duration :waveAnimator.duration}
        }
    }
    MouseArea{
        id : mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: (mouse)=> {
                       if (mouse.button == Qt.LeftButton){
                           if(root.checkable){
                               root.checked != root.checked
                           }
                           root.clicked()

                           if(root.enableClickAnimation){
                               xAnimation.from = mouse.x
                               xAnimation.to = mouse.x - waveAnimator.finalSize / 2
                               yAnimation.from = mouse.y
                               yAnimation.to = mouse.y - waveAnimator.finalSize / 2
                               waveAnimator.running = true
                           }
                       }
                   }
    }
}
