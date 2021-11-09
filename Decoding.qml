import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

ColumnLayout {
    spacing: 8

    Flickable {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.leftMargin: 8
        Layout.rightMargin: 8
        Layout.topMargin: 4
        Layout.maximumHeight: 192
        TextArea.flickable: TextArea {
            id: inputText
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
            placeholderText: "Encoded text"
            background: Rectangle {
                id:inputTextValidate
                border.width: 4
                border.color: myBackground
                color: myBackground
                radius: 4
            }
            onTextChanged: {
                if (inputText.text.length) {
                    inputTextValidate.border.color = myHighLighht
                } else {
                    inputTextValidate.border.color = myCloseBtn
                }
            }
        }
        ScrollBar.vertical: ScrollBar {}
    }

    RowLayout {
        Layout.fillWidth:true
        Layout.leftMargin: 8
        Layout.rightMargin: 8
        Layout.minimumHeight: 32
        spacing:0
        
        TextField {
            id: nKey
            selectByMouse: true
            color: myWhiteFont
            enabled: activeWindow
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.leftMargin: 0
            font.capitalization: Font.AllUppercase
            font.family: "Roboto Medium"
            placeholderTextColor: Qt.darker(myWhiteFont, 2)
            placeholderText: "N Key"
            validator: RegularExpressionValidator { regularExpression: /[0-9]+/ }
            Layout.rightMargin: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 32
            background: Rectangle {
                id: nKeyValidate
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
                    width: 6
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
                if (nKey.text.length) {
                    nKeyValidate.border.color = myHighLighht
                } else {
                    nKeyValidate.border.color = myCloseBtn
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
            Layout.leftMargin: 0
            font.capitalization: Font.AllUppercase
            font.family: "Roboto Medium"
            placeholderTextColor: Qt.darker(myWhiteFont, 2)
            placeholderText: "D Key"
            validator: RegularExpressionValidator { regularExpression: /[0-9]+/ }
            Layout.rightMargin: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 32            
            Layout.minimumWidth: 222
            Layout.maximumWidth: 222
            background: Rectangle {
                id: dKeyValidate
                color: myBackground
                border.width: 2
                border.color: myBackground
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
                    width: 6
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
                if (dKey.text.length) {
                    dKeyValidate.border.color = myHighLighht
                } else {
                    dKeyValidate.border.color = myCloseBtn
                }
            }
        }

    }

    Button {
        Layout.fillHeight: true
        Layout.rightMargin: 8
        Layout.leftMargin: 8
        Layout.bottomMargin: 0
        Layout.fillWidth: true
        Layout.minimumHeight: 32
        Layout.maximumHeight: 32
        enabled: true
        onClicked: {
            
        }
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 4

            Label{
                text: "Decode"
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
