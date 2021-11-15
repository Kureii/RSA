import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

Window {
    id: mainWindow
    visible: true
    width: 300
    height: 100
    color: "transparent"

    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property bool activeWindow: true

    property double myX: getX(mainWindow.x)
    property double myOldX: getOldX(mainWindow.x)
    property double myY: getY(mainWindow.y)
    property double myOldY: getOldY(mainWindow.y)

    property string myNKey: "0"
    property string myEKey: "0"
    property string myDKey: "0"
    property string myEncoding: ""
    property string myDecoding: ""

    property string nameDec: ""
    property string nameDKey: ""
    property string nameEKey: ""
    property string nameEnc: ""
    property string nameEncText: ""
    property string nameGen: ""
    property string nameNKey: ""
    property string nameDecTab: ""
    property string nameEncTab: ""
    property string nameOpenTxt: ""
    property string nameMode: ""
    property var nameModuleMode: []
    property var nameModuleMode2: []

    property color tmpEncodingClr: "#fff"
    property color tmpDecodingClr: "#fff"

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#F9D800"//"#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseBtn: "#de2f05"

    property bool wasEncodedText: false
    property bool wasOpenText: false
    property bool wasNkeyD: false
    property bool wasNkeyE: false
    property bool wasDKey: false
    property bool wasEKey: false
    property bool wasEncDone: false
    property bool wasDecDone: false

    function getX(x){
        if(!lang.running && !timeline.enabled){
            let tmp = x - 150
            if (tmp > 0) {
                return tmp
            } else {
                return 0
            }
        } else {
            return myX
        }
    }

    function getOldX(x){
        if(!lang.running && !timeline.enabled){
            return x
        } else {
            return myOldX
        }
    }

    function getY(y){
        if(!lang.running && !timeline.enabled){
            let tmp = y - 114
            if (tmp > 0) {
                return tmp
            } else {
                return 0
            }
        } else {
            return myY
        }
    }

    function getOldY(y){
        if(!lang.running && !timeline.enabled){
            return y
        } else {
            return myOldY
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        transformOrigin: Item.Center

        // window
        Rectangle {
            id: window
            anchors.fill: parent
            anchors.bottomMargin: 0
            color: myBackground
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
                                myX = getX(mainWindow.x)
                                myY = getY(mainWindow.y)
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
                                enabled: false
                                visible: false
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
                    id: langApp
                    currentIndex: 0
                    Layout.topMargin: 0
                    Layout.bottomMargin: 4
                    Layout.fillWidth: true
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.fillHeight: true

                    GridLayout {
                        id: language
                        Layout.topMargin: 0
                        rowSpacing: 0
                        columnSpacing: 0
                        Layout.bottomMargin: 4
                        Layout.fillWidth: true
                        Layout.rightMargin: 4
                        Layout.leftMargin: 4
                        Layout.fillHeight: true
                        columns: 2

                        Label {
                            id: englishCzech
                            text: "Language / Jazyk"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.columnSpan: 2
                            Layout.minimumHeight: 29
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            font.family: "Roboto Medium"
                            color: myWhiteFont
                        }

                        Button {
                            Layout.fillHeight: true
                            Layout.bottomMargin: -8
                            Layout.topMargin: 2
                            Layout.minimumHeight: 32
                            Layout.maximumHeight:32
                            Layout.fillWidth: true
                            enabled: true
                            onClicked: {
                                myLang.getLang("eng_US")
                                minimalise.visible = true
                                minimalise.enabled = true
                                myX = getX(mainWindow.x)
                                myY = getY(mainWindow.y)
                                timeline.enabled = true
                                lang.running = true
                            }
                            background: Rectangle {
                                id: english
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 0

                                Label{
                                    id: englishText
                                    text: "English"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                                }
                            }
                        }

                        Button {
                            Layout.fillHeight: true
                            Layout.bottomMargin: -8
                            Layout.topMargin: 2
                            Layout.minimumHeight: 32
                            Layout.maximumHeight: 32
                            Layout.fillWidth: true
                            enabled: true
                            background: Rectangle {
                                id: czech
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 0

                                Label{
                                    id: czechText
                                    text: "Czech"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                                }
                            }
                            onClicked: {
                                myLang.getLang("cs_CZ")
                                minimalise.visible = true
                                minimalise.enabled = true
                                myX = getX(mainWindow.x)
                                myY = getY(mainWindow.y)
                                timeline.enabled = true
                                lang.running = true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        anchors.bottomMargin: 4
                        color: "#00000000"
                        App {
                            anchors.fill:parent
                        }
                        Rectangle{
                            id:maskApp
                            color: myBackground2
                            anchors.fill: parent
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: myData
        function onMyNKey(n) {
            myNKey = nameNKey + ": " + n
        }

        function onMyEKey(e) {
           myEKey = nameEKey + ": " + e
        }

        function onMyDKey(d) {
            myDKey = nameDKey + ": " + d
        }

        function onMyEncoding(x) {
            myEncoding = x
        }
        function onMyDecoding(y) {
            myDecoding = y
            console.log(myDecoding);
        }
    }

    Connections {
        target: myLang
        function onNameDec(x) {
            nameDec = x
        }
        function onNameDKey(x) { 
            nameDKey = x
        }
        function onNameEKey(x) {
            nameEKey = x
        }
        function onNameEnc(x) {
            nameEnc = x
        }
        function onNameEncText(x) {
            nameEncText = x
        }
        function onNameGen(x) {
            nameGen = x
        }
        function onNameNKey(x) { 
            nameNKey = x
        }
        function onNameDecTab(x){
            nameDecTab = x
        }
        function onNameEncTab(x) {
            nameEncTab = x
        }
        function onNameOpenTxt(x) {
            nameOpenTxt = x
        }
        function onNameMode(x) {
            nameMode = x
        }
        function onNameModuleMode(x) {
            nameModuleMode = x
        }
        function onNameModuleMode2(x) {
            nameModuleMode2 = x
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: lang
                running: false
                duration: 1000
                loops: 1
                to: 1000
                from: 0
                onFinished: {
                    lang.running = false
                    timeline.enabled = false
                    maskApp.color = "#00acb1aa"
                    mainWindow.width = 600
                    mainWindow.height = 335
                    mainWindow.x = myX
                    mainWindow.y = myY
                    window.color = myBackground2
                    langApp.currentIndex = 1
                    minBtn.color = myCloseImg
                }
            }
        ]
        endFrame: 1000
        startFrame: 0
        enabled: false

        KeyframeGroup {
            target: maskApp
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.455,0.03,0.515,0.955,1,1]
                value: myBackground2
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.455,0.03,0.515,0.955,1,1]
                value: "#00acb1aa"
                frame: 1000
            }
        }
        KeyframeGroup {
            target: mainWindow
            property: "width"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 600
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 300
                frame: 0
            }
        }
        KeyframeGroup {
            target: mainWindow
            property: "x"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myX
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myOldX
                frame: 0

            }
        }
        KeyframeGroup {
            target: mainWindow
            property: "y"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myY
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myOldY
                frame: 0

            }
        }
        KeyframeGroup {
            target: mainWindow
            property: "height"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 335
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 100
                frame: 0
            }
        }
        KeyframeGroup {
            target: window
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground
                frame: 0
            }
        }
        KeyframeGroup {
            target: english
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground
                frame: 0
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }
        }
        KeyframeGroup {
            target: czech
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground
                frame: 0
            }
        }
        KeyframeGroup {
            target: englishText
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myWhiteFont
                frame: 0
            }
        }
        KeyframeGroup {
            target: czechText
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myWhiteFont
                frame: 0
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }
        }
        KeyframeGroup {
            target: englishCzech
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myWhiteFont
                frame: 0
            }

            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myBackground2
                frame: 750
            }
        }
        KeyframeGroup {
            target: langApp
            property: "currentIndex"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 0
                frame: 749
            }
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: 1
                frame: 750
            }
        }
        KeyframeGroup {
            target: minBtn
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myUpperBar
                frame: 0
            }
            Keyframe {
                easing.bezierCurve: [0.234,0.0012,0.299,0.0288,0.418,0.481,0.562,1.01,0.568,1.21,0.724,1.03,0.807,0.903,0.87,1.02,1,1]
                value: myCloseImg
                frame: 750
            }
        }
    
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}
}
##^##*/
