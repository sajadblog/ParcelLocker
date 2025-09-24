import QtQuick
import ToolBox 1.0

Item {
    id: root

    property string title : "Result"
    property bool isLockerOpen : true
    property string lockerId : ""

    signal goWelcome()

    width: window.width / 2
    height: column.height + appearanceManager.marginsBig * 2

    onVisibleChanged: {
        if(visible)
            timeoutTimer.restart()
        else
            timeoutTimer.stop()
    }

    Timer{
        id: timeoutTimer
        interval: 15000
        onTriggered: {
            root.goWelcome()
        }
    }

    Column{
        id : column
        anchors.centerIn: parent
        height: childrenRect.height
        width : childrenRect.width
        spacing: appearanceManager.itemSpacing
        Text{
            id : textItem
            text : qsTr("Locker number " + lockerId + qsTr(" is ") + (root.isLockerOpen ? qsTr("open") : qsTr("close")))
            font.pixelSize: appearanceManager.fontMediumPixelSize
            color : appearanceManager.successColor
        }
        Button{
            id : homeButton
            text : qsTr("Home")
            height : appearanceManager.iconBigSize
            anchors.horizontalCenter: textItem.horizontalCenter
            onClicked : root.goWelcome()
        }
    }
}
