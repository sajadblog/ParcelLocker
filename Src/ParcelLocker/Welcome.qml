import QtQuick
import ToolBox 1.0

Item {
    id: root

    property string title : "Welcome"
    signal startClicked()

    width: window.width / 3
    height: column.height + appearanceManager.marginsBig * 2

    Column{
        id : column
        anchors.centerIn: parent
        height: childrenRect.height
        width : childrenRect.width
        spacing: appearanceManager.itemSpacing
        Text{
            id : welcomItem
            text : qsTr("Welcome")
            font.pixelSize: appearanceManager.fontLargePixelSize
        }
        Button{
            id : startButton
            text : qsTr("Start")
            height : appearanceManager.iconBigSize
            anchors.horizontalCenter: welcomItem.horizontalCenter
            onClicked : root.startClicked()
        }
    }
}
