import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

Rectangle { 
    color: myBackground2  

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: encDecTab
            height: 56
            enabled: activeWindow
            position: TabBar.Footer
            currentIndex: 0
            Layout.fillHeight: false
            font.family: "Roboto Medium"
            Layout.rightMargin: 0
            Layout.leftMargin: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.minimumHeight: 42
            Layout.maximumWidth: width
            Layout.minimumWidth: width
            width:592

            TabButton {
                id: encodeBtnTab
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                enabled: false
                background: Rectangle {
                    color: parent.hovered && activeWindow ? Qt.lighter( myBackground, 2) : myBackground
                    anchors.fill: parent
                    Label {
                        text: nameEncTab
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: encDecTab.currentIndex == 0 ? -2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                    }

                    Rectangle {
                        id: encodeHighLight
                        height: 4
                        width: encDecTab.width / 2
                        color: myHighLighht
                        visible: true
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                    }
                }
                onClicked: {
                    //window.height = 300
                    toEncode.enabled = true
                    tabBarHightlight2.running = true
                    decodeBtnTab.enabled = true
                    encodeBtnTab.enabled = false
                }
            }

            TabButton {
                id: decodeBtnTab
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: parent.hovered && activeWindow ? Qt.lighter(myBackground,2) : myBackground
                    anchors.fill: parent
                    Label {
                        text: nameDecTab
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: encDecTab.currentIndex == 1 ? -2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                    }

                    Rectangle {
                        id: decodeHighLight
                        height: 4
                        width: encDecTab.width / 2
                        color: myHighLighht
                        visible: false
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }
                }
                onClicked: {
                    decodeHighLight.visible = true
                    toDecode.enabled= true
                    tabBarHightlight1.running =true
                    decodeBtnTab.enabled = false
                    encodeBtnTab.enabled = true


                    //window.height = 364
                }
            }

        }
        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 8
            currentIndex: encDecTab.currentIndex

            //Encoding
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.bottomMargin: 8
                Layout.topMargin: 8
                spacing: 4

                Flickable {
                    id: openTextWindow
                    Layout.fillWidth: true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.topMargin: -2
                    Layout.bottomMargin: -2
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    height: 128
                    width: 576
                    TextArea.flickable: TextArea {
                        id: openText
                        visible: true
                        selectByMouse: true
                        color: myWhiteFont
                        enabled: activeWindow
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        textFormat: Text.AutoText
                        placeholderTextColor: Qt.darker(myWhiteFont, 2)
                        font.family: "Roboto Medium"
                        font.hintingPreference: Font.PreferFullHinting
                        placeholderText: nameOpenTxt
                        background: Rectangle {
                            id: openTextValidate
                            border.width: 2
                            border.color: myBackground
                            color: myBackground
                            radius: 4
                        }
                        onTextChanged: {
                            if (openText.text.length) {
                                openTextValidate.border.color = myHighLighht
                            } else {
                                wasOpenText = true
                                openTextValidate.border.color = myCloseBtn
                            }
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                }

                Rectangle {
                    id: encKeys
                    Layout.fillWidth:true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    color: myBackground
                    clip: true
                    width: 576
                    height: 32
                    radius: 8
                    RowLayout {
                        spacing:0
                        
                        TextField {
                            id: nKeyE
                            readOnly: true
                            selectByMouse: true
                            color: myWhiteFont
                            enabled: activeWindow
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameNKey
                            //validator: RegularExpressionValidator { regularExpression: /^\+?(0|[1-9]\d*)$/ }
                            Layout.rightMargin: 0
                            Layout.fillHeight: true
                            Layout.maximumHeight: 32
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 240
                            background: Rectangle {
                                id: nKeyEValidate
                                color: myBackground
                                radius: 4
                                border.width: 2
                                border.color: myBackground
                                Rectangle {
                                    width: 6
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.rightMargin: 0
                                    color: myBackground
                                    border.width: parent.border.width
                                    border.color: parent.border.color
                                }
                                Rectangle {
                                    id: nKeyEValidateEditBorder
                                    width: 10
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: parent.border.width
                                    anchors.bottomMargin: parent.border.width
                                    anchors.rightMargin: parent.border.width
                                    color: myBackground
                                }

                            }
                            onTextChanged: {
                                if (nKeyE.text.length) {
                                    nKeyEValidate.border.color = myHighLighht
                                } else {
                                    wasNkeyE = true
                                    nKeyEValidate.border.color = myCloseBtn
                                }
                                if (eKeyValidate.border.color == nKeyEValidate.border.color) {
                                    nKeyEValidateEditBorder.anchors.rightMargin = nKeyEValidate.border.width / 2
                                    eKeyValidateEditBorder.anchors.leftMargin = eKeyValidate.border.width / 2
                                } else {
                                    nKeyEValidateEditBorder.anchors.rightMargin = nKeyEValidate.border.width
                                    eKeyValidateEditBorder.anchors.leftMargin = eKeyValidate.border.width
                                }
                            }
                        }

                        TextField {
                            id: eKey
                            selectByMouse: true
                            readOnly: true
                            color: myWhiteFont
                            enabled: activeWindow
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameEKey
                            //validator: RegularExpressionValidator { regularExpression: /^\+?(0|[1-9]\d*)$/ }
                            Layout.rightMargin: 0
                            Layout.fillHeight: true
                            Layout.maximumHeight: 32            
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 240
                            background: Rectangle {
                                id: eKeyValidate
                                color: myBackground
                                border.width: 2
                                border.color: myBackground
                                Rectangle {
                                    id: eKeyValidateEditBorder
                                    color: myBackground
                                    width: 2
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: parent.border.width
                                    anchors.bottomMargin: parent.border.width
                                    anchors.leftMargin: parent.border.width
                                }

                            }
                            onTextChanged: {
                                if (eKey.text.length) {
                                    eKeyValidate.border.color = myHighLighht
                                } else {
                                    wasEKey = true
                                    eKeyValidate.border.color = myCloseBtn
                                }
                                if (eKeyValidate.border.color == nKeyEValidate.border.color) {
                                    nKeyEValidateEditBorder.anchors.rightMargin = nKeyEValidate.border.width / 2
                                    eKeyValidateEditBorder.anchors.leftMargin = eKeyValidate.border.width / 2
                                } else {
                                    nKeyEValidateEditBorder.anchors.rightMargin = nKeyEValidate.border.width
                                    eKeyValidateEditBorder.anchors.leftMargin = eKeyValidate.border.width
                                }
                            }
                        }

                        Button {
                            id: generateBtn
                            Layout.fillHeight: true
                            Layout.topMargin: 0
                            Layout.leftMargin: 0
                            Layout.bottomMargin: 0
                            Layout.fillWidth: true
                            Layout.minimumHeight: 32
                            Layout.maximumHeight: 32
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 96
                            enabled: true
                            onClicked: {
                                myData.genKey()
                                console.log(myNKey);
                                console.log(myEKey);
                                nKeyE.text = myNKey
                                eKey.text = myEKey
                            }
                            background: Rectangle {
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 4

                                Rectangle {
                                    width: 10
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.topMargin: 0
                                    color: parent.color
                                }

                                Label{
                                    id: generateText
                                    text: nameGen
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                                }
                            }
                        }
                    }
                }

                Button {
                    id: encBtn
                    Layout.rightMargin: 8
                    Layout.leftMargin: 8
                    Layout.fillWidth: true
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    height: 32
                    width: 576
                    enabled: true
                    onClicked: {
                        console.log(nKeyE.width);
                    }
                    background: Rectangle {
                        color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                        radius: 4
                        anchors.fill: parent


                        Label{
                            text: nameEnc
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Roboto Medium"
                            color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                        }
                    }
                }
                
                /*Flickable {
                    id: encodingText
                    Layout.fillWidth: true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.topMargin: -2
                    Layout.bottomMargin: -4
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    visible: false
                    height: 150
                    width: 576
                    TextArea.flickable: TextArea {
                        id: encodedText
                        visible: true
                        selectByMouse: true
                        color: myWhiteFont
                        enabled: activeWindow
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        textFormat: Text.AutoText
                        placeholderTextColor: Qt.darker(myWhiteFont, 2)
                        font.family: "Roboto Medium"
                        font.hintingPreference: Font.PreferFullHinting
                        placeholderText: nameEncText
                        background: Rectangle {
                            id:encodedTextValidate
                            border.width: 2
                            border.color: myBackground
                            color: myBackground
                            radius: 4
                        }
                        onTextChanged: {
                            let regEx = /(?![A-F0-9\s])/gi;
                            if (encodedText.text) {
                                let found = encodedText.text.match(regEx);
                                if(found.length == 1) {
                                    encodedTextValidate.border.color = myHighLighht
                                } else {
                                    encodedTextValidate.border.color = myCloseBtn
                                }
                            } else {
                                wasEncodedText = true
                                encodedTextValidate.border.color = myCloseBtn
                            }
                            
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                } */ 
            }
            
            //Decoding
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.bottomMargin: 8
                Layout.topMargin: 8
                spacing: 6

                Flickable {
                    id: encodedTextWindow
                    Layout.fillWidth: true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.topMargin: -2
                    Layout.bottomMargin: -4
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    height: 150
                    width: 576
                    TextArea.flickable: TextArea {
                        id: encodedText
                        visible: true
                        selectByMouse: true
                        color: myWhiteFont
                        enabled: activeWindow
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        textFormat: Text.AutoText
                        placeholderTextColor: Qt.darker(myWhiteFont, 2)
                        font.family: "Roboto Medium"
                        font.hintingPreference: Font.PreferFullHinting
                        placeholderText: nameEncText
                        background: Rectangle {
                            id:encodedTextValidate
                            border.width: 2
                            border.color: myBackground
                            color: myBackground
                            radius: 4
                        }
                        onTextChanged: {
                            let regEx = /(?![A-F0-9\s])/gi;
                            if (encodedText.text) {
                                let found = encodedText.text.match(regEx);
                                if(found.length == 1) {
                                    encodedTextValidate.border.color = myHighLighht
                                } else {
                                    encodedTextValidate.border.color = myCloseBtn
                                }
                            } else {
                                wasEncodedText = true
                                encodedTextValidate.border.color = myCloseBtn
                            }
                            
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                }

                Rectangle { 
                    Layout.fillWidth:true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    width: 576
                    height: 32
                    radius:8
                    color: myBackground

                    RowLayout {
                        id: layout
                        spacing:0
                        anchors.fill: parent
                        
                        TextField {
                            id: nKeyD
                            selectByMouse: true
                            color: myWhiteFont
                            enabled: activeWindow
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            Layout.rightMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameNKey
                            validator: RegularExpressionValidator { regularExpression: /[0-9]+/ }
                            Layout.fillHeight: true
                            Layout.maximumHeight: 32
                            Layout.minimumHeight: 24
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 288
                            background: Rectangle {
                                id: nKeyDValidate
                                color: myBackground
                                radius: 4
                                border.width: 2
                                border.color: "#f0f"
                                Rectangle {
                                    width: 6
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.rightMargin: 0
                                    color: myBackground
                                    border.width: parent.border.width
                                    border.color: parent.border.color
                                }
                                Rectangle {
                                    id: nKeyDValidateEditBorder
                                    width: 10
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: parent.border.width
                                    anchors.bottomMargin: parent.border.width
                                    anchors.rightMargin: parent.border.width
                                    color: myBackground
                                }

                            }
                            onTextChanged: {
                                if (nKeyD.text.length) {
                                    nKeyDValidate.border.color = myHighLighht
                                } else {
                                    wasNkeyD = true
                                    nKeyDValidate.border.color = myCloseBtn
                                }
                                if (dKeyValidate.border.color == nKeyDValidate.border.color) {
                                    nKeyDValidateEditBorder.anchors.rightMargin = nKeyDValidate.border.width / 2
                                    dKeyValidateEditBorder.anchors.leftMargin = dKeyValidate.border.width / 2
                                } else {
                                    nKeyDValidateEditBorder.anchors.rightMargin = nKeyDValidate.border.width
                                    dKeyValidateEditBorder.anchors.leftMargin = dKeyValidate.border.width
                                }
                            }
                        }

                        TextField {
                            id: dKey
                            selectByMouse: true
                            color: myWhiteFont
                            enabled: activeWindow
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameDKey
                            validator: RegularExpressionValidator { regularExpression: /[0-9]+/ }
                            Layout.leftMargin: 0
                            Layout.rightMargin: 0
                            Layout.fillHeight: true
                            Layout.minimumHeight: 24
                            Layout.maximumHeight: 32            
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 288
                            background: Rectangle {
                                id: dKeyValidate
                                color: myBackground
                                border.width: 2
                                border.color: myBackground
                                radius: 4
                                Rectangle {
                                    width: 6
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.leftMargin: 0
                                    color: myBackground
                                    border.width: parent.border.width
                                    border.color: parent.border.color
                                }
                                Rectangle {
                                    id: dKeyValidateEditBorder
                                    width: 10
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: parent.border.width
                                    anchors.bottomMargin: parent.border.width
                                    anchors.leftMargin: parent.border.width
                                    color: myBackground
                                }

                            }
                            onTextChanged: {
                                if (dKey.text.length != 0) {
                                    dKeyValidate.border.color = myHighLighht
                                } else {
                                    wasDKey = true
                                    dKeyValidate.border.color = myCloseBtn
                                }
                                if (dKeyValidate.border.color == nKeyDValidate.border.color) {
                                    nKeyDValidateEditBorder.anchors.rightMargin = nKeyDValidate.border.width / 2
                                    dKeyValidateEditBorder.anchors.leftMargin = dKeyValidate.border.width / 2
                                } else {
                                    nKeyDValidateEditBorder.anchors.rightMargin = nKeyDValidate.border.width
                                    dKeyValidateEditBorder.anchors.leftMargin = dKeyValidate.border.width
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                        }

                        Button {
                            id: deletedBtn
                            Layout.fillHeight: true
                            Layout.topMargin: 0
                            Layout.leftMargin: 0
                            Layout.bottomMargin: 0
                            Layout.minimumHeight: 32
                            Layout.maximumHeight: 32
                            Layout.minimumWidth: width
                            Layout.maximumWidth: width
                            width: 0
                            enabled: false
                            background: Rectangle {
                                id: deletedBtnBck
                                anchors.fill: parent
                                color: "transparent"
                                radius: 4

                                Rectangle {
                                    width: 10
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.topMargin: 0
                                    color: parent.color
                                }

                                Label{
                                    id: deletedBtnText
                                    text: nameGen
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: "transparent"
                                }
                            }
                        }
                    }
                }

                Button {
                    id: decodeBtn
                    height: 32
                    Layout.rightMargin: 8
                    Layout.leftMargin: 8
                    Layout.bottomMargin: 0
                    Layout.fillWidth: true
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    width: 576
                    enabled: true
                    onClicked: {
                        console.log(nKeyD.width);
                        console.log(layout.width);
                    }
                    background: Rectangle {
                        anchors.fill: parent
                        color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                        radius: 4

                        Label{
                            text: nameDec
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Roboto Medium"
                            color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                        }
                    }
                }
                
                Rectangle {
                    visible: false
                    Layout.fillWidth:true
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    Layout.minimumHeight: 160
                    color: "#f30"
                }

            }
        }

        Timeline {
            id: toDecode
            animations: [
                TimelineAnimation {
                    id: tabBarHightlight1
                    easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                    running: false
                    duration: 1000
                    loops: 1
                    to: 1000
                    from: 0
                }
            ]
            endFrame: 1000
            startFrame: 0
            enabled: false

            KeyframeGroup {
                target: encodeHighLight
                property: "width"
                Keyframe {
                    value: 0
                    frame: 400
                }

                Keyframe {
                    value: encDecTab.width / 2
                    frame: 0
                }
            }
            KeyframeGroup {
                target: decodeHighLight
                property: "width"
                Keyframe {
                    value: encDecTab.width / 2
                    frame: 400
                }

                Keyframe {
                    value: 0
                    frame: 0
                }
            }
            KeyframeGroup {
                target: mainWindow
                property: "height"
                Keyframe {
                    value: 324
                    frame: 400
                }

                Keyframe {
                    value: 300
                    frame: 0
                }
            }
            KeyframeGroup {
                target: encodedTextWindow
                property: "height"
                Keyframe {
                    value: 150
                    frame: 500
                }

                Keyframe {
                    value: 128
                    frame: 0
                }
            }
            KeyframeGroup {
                target: deletedBtnText
                property: "color"
                Keyframe {
                    value: "#00201e1b"
                    frame: 200
                }

                Keyframe {
                    value: myWhiteFont
                    frame: 0
                }
            }
            KeyframeGroup {
                target: deletedBtn
                property: "width"
                Keyframe {
                    value: 0
                    frame: 350
                }

                Keyframe {
                    value: 96
                    frame: 0
                }
            }
            KeyframeGroup {
                target: deletedBtnBck
                property: "color"
                Keyframe {
                    value: "transparent"
                    frame: 351
                }

                Keyframe {
                    value: myBackground
                    frame: 350
                }

                Keyframe {
                    value: myBackground
                    frame: 0
                }
            }
            KeyframeGroup {
                target: dKey
                property: "width"
                Keyframe {
                    value: 288
                    frame: 500
                }

                Keyframe {
                    value: 240
                    frame: 0
                }
            }
            KeyframeGroup {
                target: dKeyValidate
                property: "radius"
                Keyframe {
                    value: 4
                    frame: 500
                }

                Keyframe {
                    value: 0
                    frame: 350
                }
            }
            KeyframeGroup {
                target: nKeyD
                property: "width"
                Keyframe {
                    value: 288
                    frame: 500
                }

                Keyframe {
                    value: 240
                    frame: 0
                }
            }
            KeyframeGroup {
                target: encodedTextValidate
                property: "border.color"
                Keyframe {
                    value: encodedText.text ? myHighLighht : (wasEncodedText ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: openTextValidate.border.color
                    frame: 0
                }
            }
            KeyframeGroup {
                target: nKeyDValidate
                property: "border.color"
                Keyframe {
                    value: nKeyD.text ? myHighLighht : (wasNkeyD ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: nKeyEValidate.border.color
                    frame: 0
                }
            }
            KeyframeGroup {
                target: dKeyValidate
                property: "border.color"
                Keyframe {
                    value: dKey.text ? myHighLighht : (wasDKey ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: eKeyValidate.border.color
                    frame: 0
                }
            }
        }

        Timeline {
            id: toEncode
            animations: [
                TimelineAnimation {
                    id: tabBarHightlight2
                    running: false
                    duration: 1000
                    loops: 1
                    to: 1000
                    from: 0
                }
            ]
            endFrame: 1000
            startFrame: 0
            enabled: false
            KeyframeGroup {
                target: encodeHighLight
                property: "width"
                Keyframe {
                    value: 0
                    frame: 0
                }

                Keyframe {
                    value: encDecTab.width / 2
                    frame: 400
                }
            }
            KeyframeGroup {
                target: decodeHighLight
                property: "width"
                Keyframe {
                    value: encDecTab.width / 2
                    frame: 0
                }

                Keyframe {
                    value: 0
                    frame: 400
                }
            }
            KeyframeGroup {
                target: mainWindow
                property: "height"
                Keyframe {
                    value: 300
                    frame: 500
                }

                Keyframe {
                    value: 324
                    frame: 0
                }
            }
            KeyframeGroup {
                target: openTextWindow
                property: "height"
                Keyframe {
                    value: 128
                    frame: 500
                }

                Keyframe {
                    value: 150
                    frame: 0
                }
            }
            KeyframeGroup {
                target: generateBtn
                property: "width"
                Keyframe {
                    value: 96
                    frame: 500
                }

                Keyframe {
                    value: 150
                    frame: 0
                }
            }
            KeyframeGroup {
                target: generateText
                property: "color"
                Keyframe {
                    value: myWhiteFont
                    frame: 500
                }

                Keyframe {
                    value: "#00201e1b"
                    frame: 150
                }
            }
            KeyframeGroup {
                target: eKey
                property: "width"
                Keyframe {
                    value: 240
                    frame: 500
                }

                Keyframe {
                    value: 288
                    frame: 0
                }
            }
            KeyframeGroup {
                target: openTextValidate
                property: "border.color"
                Keyframe {
                    value: openText.text ? myHighLighht : (wasOpenText ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: encodedTextValidate.border.color
                    frame: 0
                }
            }
            KeyframeGroup {
                target: nKeyEValidate
                property: "border.color"
                Keyframe {
                    value: nKeyE.text ? myHighLighht : (wasNkeyE ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: nKeyDValidate.border.color
                    frame: 0
                }
            }
            KeyframeGroup {
                target: eKeyValidate
                property: "border.color"
                Keyframe {
                    value: eKey.text ? myHighLighht : (wasEKey ? myCloseBtn : myBackground)
                    frame: 500
                }

                Keyframe {
                    value: dKeyValidate.border.color
                    frame: 0
                }
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:13}D{i:35}
}
##^##*/
