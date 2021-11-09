import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

ColumnLayout {


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
        Layout.fillWidth: true
        Layout.minimumHeight: 42
        

        TabButton {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            bottomPadding: 18
            padding: 8
            background: Rectangle {
                color: parent.hovered && activeWindow ? Qt.lighter( myBackground, 2) : myBackground
                anchors.fill: parent
                Label {
                    text: "Encode"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: encDecTab.currentIndex == 0 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: encDecTab.currentIndex == 0 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {
                window.height = 300
            }
        }

        TabButton {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            bottomPadding: 18
            padding: 8
            background: Rectangle {
                color: parent.hovered && activeWindow ? Qt.lighter(myBackground,2) : myBackground
                anchors.fill: parent
                Label {
                    text: "Decode"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: encDecTab.currentIndex == 1 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: encDecTab.currentIndex == 1 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {
                window.height = 364
            }
        }

    }
    StackLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 8
        currentIndex: encDecTab.currentIndex

        Encoding {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
        }
        

        Decoding {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
        }
    }
}
