import QtQuick
import ToolBox 1.0

Item {
    id: root

    property string title : "Validating"
    property int pinValue
    readonly property int retryCount : 3
    property int retryNumber: 0

    signal invalidPin(pinNumber:int)
    signal pinAccepted(pin:int, lockerId:string)
    signal timeout()

    width: window.width / 2
    height: window.height / 2

    onPinValueChanged: retryNumber = 0

    Timer{
        id: timeoutTimer
        interval: 1500
        running: root.visible
        repeat: retryCount
        onTriggered: {
            root.timeout()
        }
    }


    Connections{
        target: mainController
        function onPinNumberEvaluated(pinNumber, lockerId, items){
            if(root.pinValue != pinNumber){
                logger.newLog("Wrong Pin: current ->" + root.pinValue + "received ID ->" + pinNumber)
                return;
            }

            if(lockerId == ""){
                root.invalidPin(pinNumber)
                logger.newLog("pin is invalid : pin ->" + pinNumber )
                return;
            }else{
                root.pinAccepted(pinNumber, lockerId)
                logger.newLog("pin number accepted: pin ->" + pinNumber + "locker ID ->" + lockerId)
            }
        }
    }

    Rectangle {
        id: spinner
        width: appearanceManager.iconVeryBigSize; height: width
        radius: height / 2
        color: "transparent"
        border.width: 4
        border.color: appearanceManager.primaryColor
        anchors.centerIn: parent
        Rectangle{
            color : appearanceManager.backgroundColor
            width: spinner.border.width
            height: width
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RotationAnimator on rotation {
            from: 0
            to: 360
            duration: 1000
            loops: Animation.Infinite
        }
    }
}
