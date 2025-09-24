import QtQuick
import ToolBox 1.0

Item {
    id: root

    property alias title : welcomItem.text
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
            visible : mainController.isConnected
            font.pixelSize: appearanceManager.fontLargePixelSize
        }
        Button{
            id : startButton
            text : qsTr("Start")
            visible : mainController.isConnected
            height : appearanceManager.iconBigSize
            anchors.horizontalCenter: welcomItem.horizontalCenter
            onClicked : root.startClicked()
        }
    }
    Text{
        id : outOfSeviceItem
        text : qsTr("Out of service")
        anchors.centerIn: parent
        visible : !mainController.isConnected
        font.pixelSize: appearanceManager.fontLargePixelSize
    }
}
