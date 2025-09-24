import QtQuick
import ToolBox 1.0

Item {
    id: root

    property string title : "CodeEntry"
    signal backClicked()
    signal confirmClicked(value:int)


    width: column.width + appearanceManager.marginsBig * 2
    height: column.height + appearanceManager.marginsBig * 2

    onVisibleChanged:  {
        timeoutTimer.stop()
        pinRow.currentDigit = 0
        grid.focus = visible
        if(!visible)
            messageText.text = ""
    }

    Timer{
        id: timeoutTimer
        interval: 10000
        running: true
        onTriggered: {
            root.backClicked()
        }
    }

    Column{
        id : column
        anchors.centerIn: parent
        height: childrenRect.height
        width : numpadRow.width
        spacing: appearanceManager.itemSpacing
        Text{
            id : descriptionItem
            text : qsTr("Please enter the pin number.")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: appearanceManager.fontMediumPixelSize
        }
        Row{
            id : numpadRow
            signal newNumberPressed(value:string)
            signal resetPressed()
            signal keyboardPressed(key:int)
            height: grid.height
            width: grid.width + pinRow.width + appearanceManager.itemSpacing
            spacing : appearanceManager.itemSpacing
            Grid{
                id : grid
                property int buttonSize : appearanceManager.iconVeryBigSize
                readonly property string clearChar : "C"
                focus: true
                width: buttonSize * columns
                height: buttonSize * rows
                columns: 3
                rows : 4
                Keys.onPressed: (event)=>{
                                    if(!root.visible)
                                    return;
                                    numpadRow.keyboardPressed(event.key)
                                }

                Repeater{
                    model : [7,8,9,4,5,6,1,2,3,-1,0,10]
                    delegate : Button{
                        text : modelData < 10 ? modelData : grid.clearChar
                        enabled : modelData != -1
                        opacity : enabled ? 1.0 : 0.0
                        width : grid.buttonSize
                        height : grid.buttonSize
                        onClicked : pressed()
                        Connections{target:numpadRow; function onKeyboardPressed(key){
                            if(key - Qt.Key_0 == text){
                                pressed()
                            }
                        }}
                        function pressed(){
                            timeoutTimer.restart()
                            if(text == grid.clearChar){
                                pinRow.currentDigit = 0
                                numpadRow.resetPressed()
                            }
                            else{
                                numpadRow.newNumberPressed(text)
                                pinRow.currentDigit++
                                if(pinRow.currentDigit >= pinRow.digitCount)
                                    confirmButton.clicked()
                            }
                        }
                    }
                }
            }
            Row{
                id : pinRow
                property int digitCount: 6
                property int currentDigit: 0
                readonly property string emptyChar : "-"
                readonly property string maskChar : "x"
                height: appearanceManager.iconBigSize
                width : height * digitCount + spacing * (digitCount - 1)
                anchors.verticalCenter: grid.verticalCenter
                spacing : appearanceManager.itemSpacing
                Repeater{
                    id : pinRepeater
                    model: pinRow.digitCount
                    delegate: Rectangle{
                        property alias value : pinTextItem.value
                        height: appearanceManager.iconBigSize
                        width: height
                        radius : appearanceManager.radius
                        Text{
                            id: pinTextItem
                            property string value : ""
                            font.pixelSize: appearanceManager.fontMediumPixelSize
                            anchors.centerIn: parent
                            text: value == "" ? pinRow.emptyChar : pinRow.maskChar
                            Connections{target : root; function onBackClicked(){pinTextItem.value = ""}}
                            Connections{target : root; function onConfirmClicked(value){pinTextItem.value = ""}}
                            Connections{target : numpadRow; function onResetPressed(){pinTextItem.value = ""}}
                            Connections{target : numpadRow; function onNewNumberPressed(value){
                                if(pinRow.currentDigit == index)
                                    pinTextItem.value = value
                            }}
                        }
                    }
                }
            }
        }
        Text{
            id : messageText
            color : "red"
            anchors.horizontalCenter: parent.horizontalCenter
            visible : false
            font.bold: true
            font.pixelSize: appearanceManager.fontMediumPixelSize
        }

        Button{
            id: backButton
            text : qsTr("Back")
            anchors.left: parent.left
            width : parent.width
            onClicked: root.backClicked()
        }
        Button{
            id: confirmButton
            text : qsTr("Confirm")
            width : parent.width
            Connections{target:numpadRow; function onKeyboardPressed(key){
                if(key == Qt.Key_Enter || key == Qt.Key_Return){
                    confirmButton.clicked()
                }
            }
            }
            onClicked: {
                timeoutTimer.restart()

                var str = ""
                for (var i = 0; i < pinRepeater.count; i++) {
                    var child = pinRepeater.itemAt(i)
                    if (child) {
                        if(child.value == "")
                        {
                            messageText.visible = true
                            messageText.text = qsTr("Pin code must has 6 digits")
                            return
                        }
                        str += child.value
                    }
                }
                root.confirmClicked(parseInt(str))
            }
        }
    }
    function showMessage(message)
    {
        messageText.visible = true
        messageText.text = message
    }
}
