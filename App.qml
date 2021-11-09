import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

GridLayout {
    columns: 8

    TabBar {
        id: fiveSixTab
        height: 56
        enabled: activeWindow
        position: TabBar.Footer
        Layout.columnSpan: 8
        currentIndex: 0
        Layout.fillHeight: false
        font.family: "Roboto Medium"
        Layout.rightMargin: 0
        Layout.leftMargin: 0
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
        Layout.minimumHeight:42
        

        TabButton {
            id: fiveBtn
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
                    anchors.verticalCenterOffset: fiveSixTab.currentIndex == 0 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: fiveSixTab.currentIndex == 0 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {
                
            }
        }

        TabButton {
            id: sixBtn
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
                    anchors.verticalCenterOffset: fiveSixTab.currentIndex == 1 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: fiveSixTab.currentIndex == 1 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {

            }
        }
    }
}
