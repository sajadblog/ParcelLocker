import QtQuick
import QtQuick.Window
import ToolBox 1.0

Window {
    id: window
    width: 800
    height: 450
    visible: true
    title: qsTr("Parcel Locker")
    visibility: mainController.isFullScreen ? Window.FullScreen : Window.Windowed
    onHeightChanged: {
        appearanceManager.iconVeryBigSize = height / 10
        appearanceManager.fontLargePixelSize = appearanceManager.iconVeryBigSize / 3
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        source : "qrc:/Background.jpg"
        opacity : 0.8
    }

    Rectangle{
        id: mainFram
        height: header.height + content.height
        width: content.width
        anchors.centerIn : parent
        border.width: 1
        border.color : appearanceManager.primaryColor
        color: "transparent"
        radius :  appearanceManager.radiusBig
        clip : true
        focus : !codeEntry.visible
        Keys.onPressed: (event)=>{
                            if (event.key === Qt.Key_Escape) {
                                mainController.isFullScreen = false
                            }
                        }

        Rectangle{
            id:backgroundRect
            anchors.fill: parent
            color: appearanceManager.backgroundColor
            opacity : 0.8
            radius: parent.radius
        }

        Header{
            id:header
            width: parent.width
            height : window.height / 15
        }


        Item{
            id : content
            y : header.height
            state: welcome.title
            Welcome{
                id: welcome
                anchors.centerIn: parent
                visible : opacity > 0
                onStartClicked: content.state = codeEntry.title
            }
            CodeEntry{
                id: codeEntry
                anchors.centerIn: parent
                visible : opacity > 0
                onBackClicked: content.state = welcome.title
                onConfirmClicked: function(value){
                    validating.pinValue = value
                    content.state = validating.title
                    mainController.checkPinNumber(value)
                }
            }
            Validating{
                id: validating
                anchors.centerIn: parent
                visible : opacity > 0
                onInvalidPin : function(pinNumber){
                    if(!validating.visible)
                        return
                    content.state = codeEntry.title
                    codeEntry.showMessage(qsTr("Invalid Pin"))
                }
                onTimeout : function(pinNumber){
                    if(!validating.visible)
                        return
                    if(retryNumber < retryCount)
                    {
                        mainController.checkPinNumber(pinValue)
                        retryNumber++
                        logger.newLog("Command timeout number: " + retryNumber +", retry to send command")
                        return;
                    }

                    content.state = codeEntry.title
                    codeEntry.showMessage(qsTr("Please try again"))
                    logger.newLog("Command timeout, stop retry")
                    pinValue = 0
                }
                onPinAccepted : function(pinNumber, lockerId){
                    if(!validating.visible)
                        return
                    content.state = doorControl.title
                    doorControl.lockerId = lockerId
                }
            }
            DoorControl{
                id: doorControl
                anchors.centerIn: parent
                visible : opacity > 0
                onGoWelcome: content.state = welcome.title
                onDoorClosed: {
                    if(!doorControl.visible)
                        return
                    result.lockerId = doorControl.lockerId
                    result.isLockerOpen = false
                    content.state = result.title
                }
                onDoorOpened: {
                    if(!doorControl.visible)
                        return
                    result.lockerId = doorControl.lockerId
                    result.isLockerOpen = true
                    content.state = result.title
                }
            }
            Result{
                id: result
                anchors.centerIn: parent
                visible : opacity > 0
                onGoWelcome: {
                    content.state = welcome.title
                    logger.newLog("Go Welcome")
                }
            }

            states: [
                State {
                    name: welcome.title
                    PropertyChanges {target : welcome; opacity : 1.0}
                    PropertyChanges {target : codeEntry; opacity : 0.0}
                    PropertyChanges {target : validating; opacity : 0.0}
                    PropertyChanges {target : doorControl; opacity : 0.0}
                    PropertyChanges {target : result; opacity : 0.0}
                    PropertyChanges {content{ height : welcome.height; width : welcome.width}}
                },
                State {
                    name: codeEntry.title
                    PropertyChanges {target : welcome; opacity : 0.0}
                    PropertyChanges {target : codeEntry; opacity : 1.0}
                    PropertyChanges {target : validating; opacity : 0.0}
                    PropertyChanges {target : doorControl; opacity : 0.0}
                    PropertyChanges {target : result; opacity : 0.0}
                    PropertyChanges {content{ height : codeEntry.height; width : codeEntry.width}}
                },
                State {
                    name: validating.title
                    PropertyChanges {target : welcome; opacity : 0.0}
                    PropertyChanges {target : codeEntry; opacity : 0.0}
                    PropertyChanges {target : validating; opacity : 1.0}
                    PropertyChanges {target : doorControl; opacity : 0.0}
                    PropertyChanges {target : result; opacity : 0.0}
                    PropertyChanges {content{ height : validating.height; width : validating.width}}
                },
                State {
                    name: doorControl.title
                    PropertyChanges {target : welcome; opacity : 0.0}
                    PropertyChanges {target : codeEntry; opacity : 0.0}
                    PropertyChanges {target : validating; opacity : 0.0}
                    PropertyChanges {target : doorControl; opacity : 1.0}
                    PropertyChanges {target : result; opacity : 0.0}
                    PropertyChanges {content{ height : doorControl.height; width : doorControl.width}}
                },
                State {
                    name: result.title
                    PropertyChanges {target : welcome; opacity : 0.0}
                    PropertyChanges {target : codeEntry; opacity : 0.0}
                    PropertyChanges {target : validating; opacity : 0.0}
                    PropertyChanges {target : doorControl; opacity : 0.0}
                    PropertyChanges {target : result; opacity : 1.0}
                    PropertyChanges {content{ height : result.height; width : result.width}}
                }
            ]
            transitions: Transition {PropertyAnimation{properties: "opacity,width,height"; duration : 300}}
        }
    }
}
