import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

Window {
    id: mainWindow
    visible: true
    width: 600
    height: 600
    color: "transparent"
    
    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property bool activeWindow: true

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#F9D200"//"#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseBtn: "#de2f05"

    Flickable {
        id: flickable
        anchors.fill: parent
        
        //effects
        Rectangle {
            id: windowGlow
            color: "#cfa7e800"
            radius: 4
            anchors.fill: window
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
        }
        FastBlur {
            source: windowGlow
            radius: 12
            anchors.fill: windowGlow
            antialiasing: true
            transparentBorder: true          
        }
        HueSaturation {
            anchors.fill: window
            source: window
            saturation: activeWindow ? 0 : -.75
            lightness: activeWindow ? 0 : -0.25
        }
        HueSaturation {
            anchors.fill: windowGlow
            source: windowGlow
            saturation: activeWindow ? 0 : -.85
            lightness: activeWindow ? 0 : -0.25
            z: -1
        }

        // window
        Rectangle {
            id: window
            x: 12
            y: 12
            width: 574
            height: 574
            color: myBackground2
            radius: 4
            border.color: myUpperBar
            border.width: 4

            GridLayout {
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2
                
                //upperBar
                Rectangle {
                    id: upperBar
                    color: myUpperBar
                    radius: 4
                    Layout.rightMargin: 0
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillWidth: true
                    
                    Rectangle {
                        width: 200
                        height: 8
                        color: myUpperBar
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    RowLayout {
                        anchors.fill: parent

                        MouseArea {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                clickPos  = Qt.point(mouseX,mouseY)
                            }
                            onPositionChanged: {
                                var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                                mainWindow.x += delta.x;
                                mainWindow.y += delta.y;
                            }
                        }

                        RowLayout {
                            width: 60
                            Layout.rightMargin: 0
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            spacing: 0

                            Button {
                                id: minimalise
                                Layout.minimumWidth: 30
                                Layout.minimumHeight: 30
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle{
                                    id: rectangle
                                    color: parent.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (parent.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
                                    Rectangle{
                                        id: minBtn
                                        width: 12
                                        height: 2
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 1
                                    }
                                }
                                onClicked: mainWindow.showMinimized()
                            }

                            Button {
                                Layout.minimumWidth: 30
                                Layout.minimumHeight: 30
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle{
                                    id: rectangle1
                                    color: parent.pressed ? Qt.darker(myCloseBtn, 1.5) : (parent.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4

                                    Rectangle {
                                        width: 30
                                        height: 6
                                        anchors.bottom: parent.bottom
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottomMargin: 0
                                        color: parent.parent.pressed ? Qt.darker(myCloseBtn, 1.5) : (parent.parent.hovered ? myCloseBtn : myUpperBar)
                                    }

                                    Rectangle {
                                        width: 6
                                        height: 30
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 0
                                        color: parent.parent.pressed ? Qt.darker(myCloseBtn, 1.5) : (parent.parent.hovered ? myCloseBtn : myUpperBar)
                                    }

                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }

                                }
                                onClicked: mainWindow.close()
                            }

                        }
                    }

                    Text {
                        text: "RSA"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 36
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont
                    }

                    Image {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Image.AlignLeft
                        source: "icons/TaskBar.svg"
                        anchors.leftMargin: 8
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        sourceSize.height: 20
                        sourceSize.width: 20
                    }
                }

                StackLayout {
                    Layout.bottomMargin: 4
                    Layout.fillWidth: true
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.fillHeight: true
                    App {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
/*##^##
Designer {
    D{i:0}D{i:9;invisible:true}
}
##^##*/
