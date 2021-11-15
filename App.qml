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
                    let regEx;
                    if (modeDec.currentIndex == 0) {
                        regEx = /(?![0-9\s])/gi;
                    } else if (modeDec.currentIndex == 1 || modeDec.currentIndex == 3) {
                        regEx = /(?![A-F0-9\s])/gi;
                    } else {
                        regEx = /(?![A-G0-9\s])/gi;
                    }
                    if (encodedText.text) {
                        let found = encodedText.text.match(regEx);
                        if(found.length == 1) {
                            encodedTextValidate.border.color = myHighLighht
                        } else {
                            encodedTextValidate.border.color = myCloseBtn
                        }
                    } else if(wasEncodedText) {
                        encodedTextValidate.border.color = myCloseBtn
                    } else {
                        encodedTextValidate.border.color = myBackground
                    }
                    delField.visible = true
                    decodeHighLight.visible = true
                    toDecode.enabled= true
                    tabBarHightlight1.running =true
                    decodeBtnTab.enabled = false
                    encodeBtnTab.enabled = true
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
                // Mode
                Rectangle {
                    Layout.leftMargin: 8
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    height: 32
                    width: 576
                    color: myBackground
                    radius: 4
                    RowLayout {
                        anchors.fill: parent
                    

                        Label {
                            text: nameMode
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.family: "Roboto Medium"
                            color: myWhiteFont
                        }
                        ComboBox {
                            id: modeEnc
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            currentIndex: 0
                            font.family: "Roboto Medium"
                            model: nameModuleMode
                            
                            delegate: ItemDelegate {
                                width: modeEnc.width - 10
                                height: 22
                                contentItem: Text {
                                    text: modelData
                                    color: parent.highlighted ? myUpperBar : myWhiteFont
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.rightMargin: 0
                                    anchors.horizontalCenter: mainWindow.horizontalCenter
                                    font.family: "Roboto Medium"
                                }
                                highlighted: modeEnc.highlightedIndex === index
                                Component.onCompleted: {
                                    background.color =  myBackground
                                    background.radius = 2
                                }
                                Binding {
                                    target: background
                                    property: "color"
                                    value: highlighted ? myHighLighht : myBackground
                                }                                    
                            }

                            indicator: Image {
                                anchors.verticalCenter: modeEnc.verticalCenter
                                anchors.right: modeEnc.right
                                source: "icons/UpDown.svg"
                                anchors.rightMargin: 6
                                sourceSize.height: 10
                                sourceSize.width: 10
                                fillMode: Image.Pad                                        
                                    
                            }

                            contentItem: Text {
                                text: modeEnc.displayText
                                font: modeEnc.font
                                color: modeEnc.pressed ? myCloseImg : myWhiteFont
                                verticalAlignment: Text.AlignVCenter
                                anchors.horizontalCenter: modeEnc.horizontalCenter
                                elide: Text.ElideRight
                                anchors.verticalCenter: modeEnc.verticalCenter
                                
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 25
                                radius: 4
                                color: myBackground
                            }

                            popup: Popup {
                                y: modeEnc.height - 1
                                width: modeEnc.width
                                implicitHeight: contentItem.implicitHeight
                                padding: 5
                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: contentHeight + 10
                                    model: modeEnc.popup.visible ? modeEnc.delegateModel : null
                                    currentIndex: modeEnc.highlightedIndex
                                }                                        

                                background: Rectangle {
                                    border.width: 1
                                    border.color: myHighLighht
                                    radius:4
                                    color: myBackground
                                }
                            }

                            onActivated: {
                                if (wasEncDone) {
                                    encodingTextEditBorder.border.color = myCloseBtn
                                    tmpEncodingClr = myCloseBtn
                                }
                            }
                        }
                    }  
                }
                // input text
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
                            encodingTextEditBorder.border.color = myCloseBtn
                            tmpEncodingClr = myCloseBtn    
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
                // keys
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
                        
                        // N Key
                        TextField {
                            id: nKeyE
                            enabled: false
                            readOnly: true
                            selectByMouse: false
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameNKey
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
                                    anchors.rightMargin: parent.border.width / 2
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
                            }
                        }
                        // E Key
                        TextField {
                            id: eKey
                            selectByMouse: false
                            enabled: false
                            readOnly: true
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Roboto Medium"
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            placeholderText: nameEKey
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
                                    anchors.leftMargin: parent.border.width / 2
                                }

                            }
                            onTextChanged: {
                                
                                if (eKey.text.length) {
                                    eKeyValidate.border.color = myHighLighht
                                } else {
                                    wasEKey = true
                                    eKeyValidate.border.color = myCloseBtn
                                }
                            }
                        }
                        // generate
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
                                eKey.enabled = true
                                nKeyE.enabled = true
                                eKey.selectByMouse = true
                                nKeyE.selectByMouse = true
                                myData.genKey()
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
                // encoding button
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
                        if (openText.text && nKeyE.text) {
                            myData.enc(openText.text, 
                                        nKeyE.text.substring((nameNKey.length + 2), nKeyE.text.length), 
                                        eKey.text.substring((nameEKey.length + 2), eKey.text.length), 
                                        modeEnc.currentIndex)
                            wasEncDone = true
                            modeDec.currentIndex = modeEnc.currentIndex
                            encodingTextEditBorder.border.color = myHighLighht
                            tmpEncodingClr = myHighLighht
                            nKeyD.text = myNKey.substring((nameNKey.length + 2), myNKey.length)
                            dKey.text = myDKey.substring((nameDKey.length + 2), myDKey.length)
                            if (mainWindow.height < 400){
                                encodeHighLight.width = encDecTab.width / 2
                                dKeyE.visible = true
                                decodeHighLight.visible = false
                                encodingText.visible = true
                                encoding.enabled = true
                                encodingAnm.running = true
                                openTextValidate.border.color = myHighLighht
                                nKeyEValidate.border.color = myHighLighht
                                eKeyValidate.border.color = myHighLighht
                            }
                        } else {
                            if (!openText.text && !nKeyE.text) {
                                nKeyEValidate.border.color = myCloseBtn
                                eKeyValidate.border.color = myCloseBtn
                                openTextValidate.border.color = myCloseBtn
                            } else if (openText.text) {
                                nKeyEValidate.border.color = myCloseBtn
                                eKeyValidate.border.color = myCloseBtn
                            } else {
                                openTextValidate.border.color = myCloseBtn
                            }
                        }
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
                // decode key
                TextField {
                    id: dKeyE
                    Layout.rightMargin: 16
                    Layout.maximumWidth: 576
                    Layout.minimumWidth: 576
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    height: 0
                    horizontalAlignment: Text.AlignHCenter
                    font.capitalization: Font.AllUppercase
                    readOnly: true
                    selectByMouse: true
                    visible: false
                    color: myWhiteFont
                    font.family: "Roboto Medium"
                    text: myDKey
                    background: Rectangle {
                        color: myBackground
                        radius: 4
                        border.width: 2
                        border.color: myHighLighht
                    }
                    onTextChanged: {
                        encodingTextEditBorder.border.color = myCloseBtn
                        tmpEncodingClr = myCloseBtn
                    }
                }
                // encoded text
                Flickable {
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
                        id: encodingTextEdit
                        visible: true
                        readOnly: true
                        selectByMouse: true
                        enabled: true
                        color: myWhiteFont
                        text: myEncoding
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        placeholderText: myEncoding
                        textFormat: Text.AutoText
                        font.family: "Roboto Medium"
                        font.hintingPreference: Font.PreferFullHinting
                        background: Rectangle {
                            id: encodingTextEditBorder
                            border.width: 2
                            border.color: myHighLighht
                            color: myBackground
                            radius: 4
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                } 
            }
            
            //Decoding
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.bottomMargin: 8
                Layout.topMargin: 8
                spacing: 4
                // Mode
                Rectangle {
                    Layout.leftMargin: 8
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumWidth: width
                    Layout.minimumWidth: width
                    height: 32
                    width: 576
                    color: myBackground
                    radius: 4
                    RowLayout {
                        anchors.fill: parent
                        Label {
                            text: nameMode
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.family: "Roboto Medium"
                            color: myWhiteFont
                        }
                        ComboBox {
                            id: modeDec
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            currentIndex: 0
                            font.family: "Roboto Medium"
                            model: nameModuleMode2
                            
                            delegate: ItemDelegate {
                                width: modeDec.width - 10
                                height: 22
                                contentItem: Text {
                                    text: modelData
                                    color: parent.highlighted ? myUpperBar : myWhiteFont
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.rightMargin: 0
                                    anchors.horizontalCenter: mainWindow.horizontalCenter
                                    font.family: "Roboto Medium"
                                }
                                highlighted: modeDec.highlightedIndex === index
                                Component.onCompleted: {
                                    background.color =  myBackground
                                    background.radius = 2
                                }
                                Binding {
                                    target: background
                                    property: "color"
                                    value: highlighted ? myHighLighht : myBackground
                                }                                    
                            }

                            indicator: Image {
                                anchors.verticalCenter: modeDec.verticalCenter
                                anchors.right: modeDec.right
                                source: "icons/UpDown.svg"
                                anchors.rightMargin: 6
                                sourceSize.height: 10
                                sourceSize.width: 10
                                fillMode: Image.Pad                                        
                                    
                            }

                            contentItem: Text {
                                text: modeDec.displayText
                                font: modeDec.font
                                color: modeDec.pressed ? myCloseImg : myWhiteFont
                                verticalAlignment: Text.AlignVCenter
                                anchors.horizontalCenter: modeDec.horizontalCenter
                                elide: Text.ElideRight
                                anchors.verticalCenter: modeDec.verticalCenter
                                
                            }

                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 25
                                radius: 0
                                color: myBackground
                            }

                            popup: Popup {
                                y: modeDec.height - 1
                                width: modeDec.width
                                implicitHeight: contentItem.implicitHeight
                                padding: 5
                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: contentHeight + 10
                                    model: modeDec.popup.visible ? modeDec.delegateModel : null
                                    currentIndex: modeDec.highlightedIndex
                                }                                        

                                background: Rectangle {
                                    border.width: 1
                                    border.color: myHighLighht
                                    radius:4
                                    color: myBackground
                                }
                            }

                            onActivated: {
                                decodingTextEditBorder.border.color = myCloseBtn
                                tmpDecodingClr = myCloseBtn
                                let regEx;
                                if (modeDec.currentIndex == 0) {
                                    regEx = /(?![0-9\s])/gi;
                                } else if (modeDec.currentIndex == 1 || modeDec.currentIndex == 3) {
                                    regEx = /(?![A-F0-9\s])/gi;
                                } else {
                                    regEx = /(?![A-G0-9\s])/gi;
                                }
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
                    }  
                }
                // input text
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
                            decodingTextEditBorder.border.color = myCloseBtn
                            tmpDecodingClr = myCloseBtn
                            let regEx;
                            if (modeDec.currentIndex == 0) {
                                regEx = /(?![0-9\s])/gi;
                            } else if (modeDec.currentIndex == 1 || modeDec.currentIndex == 3) {
                                regEx = /(?![A-F0-9\s])/gi;
                            } else {
                                regEx = /(?![A-G0-9\s])/gi;
                            }
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
                // keys
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
                                decodingTextEditBorder.border.color = myCloseBtn
                                tmpEncodingClr = myCloseBtn
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
                                decodingTextEditBorder.border.color = myCloseBtn
                                tmpDecodingClr = myCloseBtn
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
                // decoding btn
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
                        if (encodedText.text && encodedTextValidate.border.color == myHighLighht
                        && nKeyD.text && dKey.text) {
                            nKeyDValidate.border.color = myCloseBtn
                            myData.dec(encodedText.text, 
                                        nKeyD.text.toString(), 
                                        dKey.text.toString(), 
                                        modeDec.currentIndex)
                            nKeyDValidate.border.color = myHighLighht
                            decodingTextEditBorder.border.color = myHighLighht
                            tmpDecodingClr = myHighLighht
                            decodingText.visible = true
                            if (!wasDecDone) {
                                decoding.enabled = true
                                decodingAnm.running = true
                            }
                            wasDecDone = true
                        } else  {
                            if (!encodedText.text) {
                                encodedTextValidate.border.color = myCloseBtn
                            }
                            if (!nKeyD.text) {
                                nKeyDValidate.border.color = myCloseBtn
                            }
                            if (!dKey.text) {
                                dKeyValidate.border.color = myCloseBtn
                            }
                        }
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
                // delety field
                TextField {
                    id: delField
                    Layout.rightMargin: 16
                    Layout.maximumWidth: 576
                    Layout.minimumWidth: 576
                    Layout.maximumHeight: height
                    Layout.minimumHeight: height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    height: 32
                    horizontalAlignment: Text.AlignHCenter
                    font.capitalization: Font.AllUppercase
                    visible: false
                    color: myWhiteFont
                    font.family: "Roboto Medium"
                    text: myDKey
                    background: Rectangle {
                        id: delBorder
                        color: myBackground
                        radius: 4
                        border.width: 2
                        border.color: myHighLighht
                    }
                }
                // decoded text
                Flickable {
                    id: decodingText
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
                        id: decodingTextEdit
                        visible: true
                        readOnly: true
                        selectByMouse: true
                        enabled: true
                        color: myWhiteFont
                        text: myDecoding
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        placeholderText: myEncoding
                        textFormat: Text.AutoText
                        font.family: "Roboto Medium"
                        font.hintingPreference: Font.PreferFullHinting
                        background: Rectangle {
                            id: decodingTextEditBorder
                            border.width: 2
                            border.color: myHighLighht
                            color: myBackground
                            radius: 4
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
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
                    duration: wasEncDone || wasDecDone ? (wasEncDone && wasDecDone ? 750 : 2000): 500
                    loops: 1
                    to: 500
                    from: 0
                    onFinished: {
                        tabBarHightlight1.running = false
                        toDecode.enabled = false
                        delField.visible = false
                        encodeHighLight.width = 0
                        decodeHighLight.width = encDecTab.width / 2
                        if (wasDecDone) {
                            mainWindow.height = 484                          
                        } else {
                            mainWindow.height = 354
                        }
                        encodedTextWindow.height = 150
                        deletedBtnText.color = "#00000000"
                        deletedBtn.width = 0
                        dKey.width = 288
                        dKeyValidate.radius = 4
                        nKeyD.width = 288
                        encodedTextValidate.border.color = encodedText.text ? myHighLighht : (wasEncodedText ? myCloseBtn : myBackground)
                        nKeyDValidate.border.color = nKeyD.text ? myHighLighht : (wasNkeyD ? myCloseBtn : myBackground)
                        dKeyValidate.border.color = dKey.text ? myHighLighht : (wasDKey ? myCloseBtn : myBackground)
                    }
                }
            ]
            endFrame: 500
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
                    value: wasDecDone ? 484 : 354
                    frame: 500
                }

                Keyframe {
                    value: wasEncDone ? 522 : 335
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
            KeyframeGroup {
                target: delField
                property: "visible"

                Keyframe {
                    value: wasEncDone || wasDecDone ? true : false
                    frame: 300
                }
                Keyframe {
                    value: false
                    frame: 301
                }
                Keyframe {
                    value: wasEncDone || wasDecDone ? true : false
                    frame: 1
                }
                Keyframe {
                    value: false
                    frame: 0
                }
            }
            KeyframeGroup {
                target: delField
                property: "height"
                Keyframe {
                    value: 32
                    frame: 0
                }
                Keyframe {
                    value: 0
                    frame: 301
                }
            }
            KeyframeGroup {
                target: decodingText
                property: "visible"

                Keyframe {
                    value: wasEncDone || wasDecDone ? true : false
                    frame: 299
                }
                Keyframe {
                    value: wasDecDone ? true : false
                    frame: 300
                }
                Keyframe {
                    value: wasEncDone || wasDecDone ? true : false
                    frame: 1
                }
                Keyframe {
                    value: wasDecDone ? true : false
                    frame: 0
                }
            }
            KeyframeGroup {
                target: decodingText
                property: "height"
                Keyframe {
                    value: 150
                    frame: 0
                }
                Keyframe {
                    value: 128
                    frame: 401
                }
            }
            KeyframeGroup {
                target: decodingTextEditBorder
                property: "border.color"
                Keyframe {
                    value: encodingTextEditBorder.border.color
                    frame: 0
                }
                Keyframe {
                    value: wasDecDone ? tmpDecodingClr : myBackground
                    frame: 300
                }
            }
            KeyframeGroup {
                target: delBorder
                property: "border.color"
                Keyframe {
                    value: myHighLighht
                    frame: 0
                }
                Keyframe {
                    value: myBackground
                    frame: 300
                }
            }            
        }

        Timeline {
            id: toEncode
            animations: [
                TimelineAnimation {
                    id: tabBarHightlight2
                    running: false
                    duration: wasEncDone || wasDecDone ? (wasEncDone && wasDecDone ? 750 : 2000): 500
                    loops: 1
                    to: 500
                    from: 0
                    onFinished: {
                        toEncode.enabled = false
                        tabBarHightlight2.running = false
                        if (wasEncDone) {
                            mainWindow.height = 522
                        } else {
                            mainWindow.height = 333
                        }
                        decodeHighLight.visible = false
                        encodeHighLight.width = encDecTab.width / 2
                    }
                }
            ]
            endFrame:500
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
                    frame: 1
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
                    value: wasEncDone ? 522 : 335
                    frame: 500
                }

                Keyframe {
                    value: wasDecDone ? 484 : 354
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
                target: dKeyE
                property: "height"
                Keyframe {
                    value: 32
                    frame: 500
                }

                Keyframe {
                    value: 0
                    frame: 125
                }
            }
            KeyframeGroup {
                target: encodingText
                property: "height"
                Keyframe {
                    value: 150
                    frame: 500
                }

                Keyframe {
                    value: wasEncDone && wasDecDone ? 128 : 0
                    frame: wasEncDone && wasDecDone ? 0 : 125
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

        Timeline {
            id: encoding
            currentFrame: 0
            animations: [
                TimelineAnimation {
                    id: encodingAnm
                    easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                    running: false
                    duration: 2000
                    loops: 1
                    to: 2000
                    from: 0
                    onFinished: {
                        encoding.enabled = false
                        encodingAnm.running = false
                        dKeyE.height = 32
                        encodingText.height = 150
                        mainWindow.height = 522
                    }
                }
            ]
            endFrame: 2000
            startFrame: 0
            enabled: false

            KeyframeGroup {
                target: dKeyE
                property: "visible"
                Keyframe {
                    frame: 1
                    value: true
                }

                Keyframe {
                    frame: 0
                    value: false
                }
            }

            KeyframeGroup {
                target: dKeyE
                property: "height"
                Keyframe {
                    frame: 1
                    value: 0
                }

                Keyframe {
                    frame: 0
                    value: 0
                }

                Keyframe {
                    frame: 2000
                    value: 32
                }
            }

            KeyframeGroup {
                target: encodingText
                property: "visible"
                Keyframe {
                    frame: 0
                    value: true
                }
            }

            KeyframeGroup {
                target: encodingText
                property: "height"
                Keyframe {
                    frame: 0
                    value: 0
                }

                Keyframe {
                    frame: 2000
                    value: 150
                }
            }

            KeyframeGroup {
                target: mainWindow
                property: "height"
                Keyframe {
                    frame: 0
                    value: 338
                }

                Keyframe {
                    frame: 2000
                    value: 522
                }
            }
        }

        Timeline {
            id: decoding
            animations: [
                TimelineAnimation {
                    id: decodingAnm
                    easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                    running: false
                    duration: 2000
                    loops: 1
                    to: 2000
                    from: 0
                }
            ]
            endFrame: 2000
            startFrame: 0
            enabled: false

            KeyframeGroup {
                target: mainWindow
                property: "height"
                Keyframe {
                    frame: 0
                    value: 354
                }

                Keyframe {
                    frame: 2000
                    value: 484
                }
            }

            KeyframeGroup {
                target: decodingText
                property: "height"
                Keyframe {
                    frame: 0
                    value: 0
                }

                Keyframe {
                    frame: 2000
                    value: 128
                }
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
