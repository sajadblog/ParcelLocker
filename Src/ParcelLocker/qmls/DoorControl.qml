import QtQuick
import QtTest 1.0
import ToolBox 1.0

Item {
    id: root

    property string title : "Door Control"
    property string lockerId : ""
    readonly property int retryCount : 3
    property int retryNumber: 0
    property bool isDoorOpen : doorController.isDoorOpen(lockerId)

    signal goWelcome()
    signal doorOpened()
    signal doorClosed()


    width: window.width / 2
    height: column.height + appearanceManager.marginsBig * 2

    onVisibleChanged: {
        if(visible)
            timeoutTimer.restart()
        else
        {
            timeoutTimer.stop()
            messageText.text = ""
        }
    }

    Connections{
        target: doorController
        function onStatusChanged(lockerId, isOpen, success){
            if(lockerId != root.lockerId){
                logger.newLog("Wrong LockerID: current ->" + root.lockerId + "received ID ->" + lockerId)
                return;
            }
            if(root.isDoorOpen == isOpen){
                logger.newLog("Wrong locker command: current ->" + root.isDoorOpen + "received ID ->" + isOpen)
                return;
            }

            if(success){
                if(isOpen)
                    root.doorOpened()
                else
                    root.doorClosed()
            }else{
                messageText.text = qsTr("Rejected, Please try again")
                logger.newLog("request rejected")
            }
            orderTimeoutTimer.stop()
        }
    }

    Timer{
        id: timeoutTimer
        interval: 30000
        running: root.visible
        onTriggered: {
            logger.newLog("Timeout, Go welcome")
            root.goWelcome()
        }
    }


    Timer{
        id: orderTimeoutTimer
        interval: 1500
        repeat: retryCount
        onTriggered: {
            if(retryNumber < retryCount)
            {
                logger.newLog("Command timeout number: " + retryNumber +", retry to send command")

                if(root.isDoorOpen)
                    doorController.close(lockerId)
                else
                    doorController.open(lockerId)
                retryNumber++
                return
            }
            logger.newLog("Command timeout, stop retry")
            messageText.text = qsTr("Timeout, Please try again")
            orderTimeoutTimer.stop()
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
            text : qsTr("Your Parcel is in Locker " + lockerId + " : " + (root.isDoorOpen ? qsTr("is open") : qsTr("is closed")))
            font.pixelSize: appearanceManager.fontMediumPixelSize
        }
        Text{
            id : messageText
            font.pixelSize: appearanceManager.fontMediumPixelSize
            color : "red"
            visible : text != ""
            font.bold: true
        }
        Button{
            text : root.isDoorOpen ? qsTr("Close") : qsTr("Open")
            height : appearanceManager.iconBigSize
            width : parent.width
            enabled : !orderTimeoutTimer.running // TODO : there should be a better busy waiting indicator
            opacity : enabled ? 1.0 : 0.5
            onClicked : {
                if(!mainController.isConnected)
                {
                    logger.newLog( "Connections lost : open/close command")
                    messageText.text = qsTr("Connections lost, Please try later")
                    return
                }

                resetValues()
                if(!root.isDoorOpen)
                    doorController.open(lockerId)
                else
                    doorController.close(lockerId)
                logger.newLog( isDoorOpen ? "Close command sent" :"Open command sent")
            }
        }
        Button{
            id : homeButton
            text : qsTr("Home")
            height : appearanceManager.iconBigSize
            width : parent.width
            onClicked : root.goWelcome()
        }

    }
    function resetValues()
    {
        orderTimeoutTimer.restart()
        timeoutTimer.restart()
        retryNumber = 0;
        messageText.text = ""
    }
}
