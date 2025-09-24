import QtQuick
import ToolBox 1.0

Item{
    id:root
    Item{
        id : content
        anchors.fill: parent
        anchors.margins: appearanceManager.margins
        ColorizeImage {
            id: connectionImage
            height : parent.height
            width : height
            source : "qrc:/NoWifi_48.png"
            opacity : !mainController.isConnected ? 1 : 0
            color: appearanceManager.primaryColor
            OpacityAnimator on opacity{
                from: 0;to: 1;
                duration: 1000
                running: !mainController.isConnected
                loops : Animation.Infinite
                onRunningChanged: connectionImage.opacity = 0.0
            }
            MouseArea{
                id: mouseArea
                hoverEnabled: true
                anchors.fill: parent
                onClicked: mainController.isConnected = !mainController.isConnected
            }
        }
        Rectangle{
            id: noWifiRectangle
            anchors.fill: connectionImage
            opacity : 0.5
            visible: mouseArea.containsMouse
        }
        Button{
            height : parent.height
            anchors.right: darkModeButton.left
            anchors.rightMargin: appearanceManager.itemSpacing
            text: mainController.isEnglish ? qsTr("English") : qsTr("Portuguese")
            onClicked : mainController.isEnglish = !mainController.isEnglish
        }
        Button{
            id: darkModeButton
            height : parent.height
            anchors.right: parent.right
            text: appearanceManager.isDark ? qsTr("Light Mode") : qsTr("Dark Mode")
            onClicked : appearanceManager.isDark = !appearanceManager.isDark
        }
    }

    Rectangle{
        id: bottomLine
        height: 1
        width: parent.width
        color: appearanceManager.primaryColor
        anchors.bottom: parent.bottom
    }
}
