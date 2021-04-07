import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.11

Window {
    width: 1280
    height: 720
    visible: true
    color: "#00000000"
    property alias tabButton2: tabButton2
    property alias tabButton1: tabButton1
    property alias tabButton: tabButton
    property alias bar: bar
    property alias swipeView: swipeView
    property alias page2: page2
    property alias page1: page1
    property alias page: page
    property alias scrollView: scrollView
    property alias textArea: textArea
    property alias fileField: fileField
    property alias fileButton: fileButton
    property alias readButton: readButton
    property alias groupBox: groupBox
    property alias windowPane: windowPane
    property alias progressBar: progressBar
    property alias exitButton: exitButton
    property alias writeButton: writeButton
    title: "SIGS EXAMPLE ACHITECTURE - Python, QT & QML"
    maximumWidth: 1280
    maximumHeight: 720
    minimumHeight: 720
    minimumWidth: 1280

    property string filePath: ""

    // Removes title bar and ability to move window
    flags: Qt.Window //| Qt.FramelessWindowHint

    Connections {


        /* this target ties the backend to the front end, you must call this target to access QT Slots (METHODS!)
            It is found in the Main.Py file as part of the engine root context.
        */
        target: main


        /* Callback method for reading data into the textBox, we cant pass data directly back and forth (which SUX, but typical web-like stuff), must use
        call back signals. Thus, the signal needs to match the signal variable in the backend but must begin with 'on'. This (signals) is a
        very odd way of doing things and is specific to QT.*/
        function onReadText(text) {
            textArea.text = text
        }

        function onReadPath(text) {
            filePath = text
        }
    }

    Rectangle {
        id: rectangle
        color: "#5d7054"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        TabBar {
            id: bar
            width: parent.width
            anchors.top: parent.top
            currentIndex: 0
            anchors.topMargin: 0
            layer.format: ShaderEffectSource.Alpha
            font.family: "Verdana"
            font.capitalization: Font.AllUppercase
            font.bold: true
            font.pointSize: 10
            TabButton {
                id: tabButton
                x: 0
                y: 0
                width: 426
                height: 40
                text: qsTr("Home")
                display: AbstractButton.TextBesideIcon
            }
            TabButton {
                id: tabButton1
                x: 427
                y: 0
                width: 431
                height: 40
                text: qsTr("Discover")
            }
            TabButton {
                id: tabButton2
                x: 859
                y: 0
                width: 421
                height: 40
                text: qsTr("Activity")
            }
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 54
            width: 1280
            height: 658
            color: "#00000000"

            SwipeView {
                id: swipeView
                anchors.fill: parent
                interactive: false
                currentIndex: bar.currentIndex
                Page {
                    id: page
                    width: 1066
                    height: 640

                    Pane {
                        id: windowPane
                        anchors.fill: parent

                        FileDialog {
                            id: fileDialog
                            title: "Please choose a file"
                            nameFilters: ["*"]
                            selectFolder: false
                            onAccepted: {
                                fileField.text = fileDialog.fileUrl.toString(
                                            ).toLowerCase().substring(
                                            8, fileDialog.fileUrl.length)
                                main.print("User has selected " + fileField.text)
                                main.setFilePath(fileDialog.fileUrl)


                                /* File is stored in class var
                    Then push to text box
                main.openFile(fileDialog.fileUrl)*/
                                fileDialog.close()
                            }
                        }

                        GroupBox {
                            id: groupBox
                            x: 0
                            y: 336
                            width: 1240
                            height: 242
                            title: qsTr("Group Box")

                            Button {
                                id: readButton
                                x: 296
                                y: 99
                                text: "Read"
                                onClicked: {


                                    /* File is stored in class var
                        Then push to text box */
                                    main.openFile(filePath)
                                }
                            }

                            Button {
                                id: writeButton
                                x: 522
                                y: 99
                                text: "Write"
                                onClicked: {
                                    //TODO: Debug Test, REMOVE
                                    main.sayMyName("Bryan")
                                }
                            }

                            Button {
                                id: exitButton
                                x: 755
                                y: 99
                                text: qsTr("Exit")
                                onClicked: {
                                    main.closeApp()
                                }
                            }
                        }

                        ProgressBar {
                            id: progressBar
                            x: 0
                            y: 324
                            width: 1240
                            height: 6
                            value: 0
                        }

                        Button {
                            id: fileButton
                            x: 0
                            y: 10
                            text: qsTr("Locate File")
                            onClicked: {
                                fileDialog.open()
                            }
                        }

                        TextField {
                            id: fileField
                            x: 106
                            y: 10
                            width: 439
                            height: 40
                            placeholderText: qsTr("Text Field")
                        }

                        ScrollView {
                            id: scrollView
                            x: 0
                            y: 56
                            width: 1240
                            height: 246

                            TextArea {
                                id: textArea
                                anchors.fill: parent
                                wrapMode: Text.Wrap
                                renderType: Text.NativeRendering
                                layer.wrapMode: ShaderEffectSource.RepeatVertically
                                rotation: 0
                                placeholderText: qsTr("Text Area")
                            }
                        }

                        RoundButton {
                            id: clearButton
                            x: 560
                            y: 10
                            text: "Clear"
                            onClicked: {
                                main.setFilePath("")
                            }

                            Connections {
                                target: clearButton
                                onClicked: {
                                    fileField.clear()
                                    textArea.clear()
                                    main.print("Cleared All Fields!")
                                }
                            }
                        }
                    }

                    PageIndicator {
                        id: pageIndicator1
                        x: 1216
                        y: 0
                        count: 3
                    }
                }

                Page {
                    id: page1
                    width: 1066
                    height: 640

                    Pane {
                        id: pane
                        anchors.fill: parent

                        GroupBox {
                            id: groupBox1
                            x: 26
                            y: 396
                            width: 1214
                            height: 175
                            title: qsTr("Group Box")

                            Button {
                                id: button
                                x: 508
                                y: 68
                                text: qsTr("Button")
                            }

                            ComboBox {
                                id: comboBox
                                x: 78
                                y: 68
                            }
                        }

                        Dial {
                            id: dial
                            x: 26
                            y: 122
                        }

                        PageIndicator {
                            id: pageIndicator
                            x: 1192
                            y: 0
                            currentIndex: 1
                            count: 3
                        }

                        CheckBox {
                            id: checkBox
                            x: 336
                            y: 133
                            text: qsTr("Check Box")
                        }

                        RadioButton {
                            id: radioButton
                            x: 336
                            y: 204
                            text: qsTr("Radio Button")
                        }

                        Switch {
                            id: switch1
                            x: 339
                            y: 266
                            text: qsTr("Switch")
                        }

                        RoundButton {
                            id: roundButton
                            x: 613
                            y: 133
                            text: "+"
                        }

                        DelayButton {
                            id: delayButton
                            x: 589
                            y: 194
                            text: qsTr("Delay Button")
                        }
                    }
                }

                Page {
                    id: page2
                    width: 1066
                    height: 640

                    Pane {
                        id: pane1
                        anchors.fill: parent

                        PageIndicator {
                            id: pageIndicator2
                            x: 1192
                            y: 0
                            currentIndex: 2
                            count: 3
                        }

                        ListView {
                            id: listView
                            x: 0
                            y: 0
                            width: 315
                            height: 451
                            delegate: Item {
                                x: 5
                                width: 80
                                height: 40
                                Row {
                                    id: row1
                                    Rectangle {
                                        width: 40
                                        height: 40
                                        color: colorCode
                                    }

                                    Text {
                                        text: name
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.bold: true
                                    }
                                    spacing: 10
                                }
                            }
                            model: ListModel {
                                ListElement {
                                    name: "Grey"
                                    colorCode: "grey"
                                }

                                ListElement {
                                    name: "Red"
                                    colorCode: "red"
                                }

                                ListElement {
                                    name: "Blue"
                                    colorCode: "blue"
                                }

                                ListElement {
                                    name: "Green"
                                    colorCode: "green"
                                }
                            }

                            Column {
                                id: column
                                x: 911
                                y: 170
                                width: 127
                                height: 312

                                BorderImage {
                                    id: borderImage
                                    width: 100
                                    height: 100
                                    source: "qrc:/qtquickplugin/images/template_image.png"
                                }

                                BorderImage {
                                    id: borderImage1
                                    width: 100
                                    height: 100
                                    source: "qrc:/qtquickplugin/images/template_image.png"
                                }

                                BorderImage {
                                    id: borderImage2
                                    width: 100
                                    height: 100
                                    source: "qrc:/qtquickplugin/images/template_image.png"
                                }
                            }
                        }

                        Slider {
                            id: slider
                            x: 515
                            y: 25
                            value: 0.5
                        }

                        Label {
                            id: label
                            x: 515
                            y: 104
                            text: qsTr("Label")
                        }

                        RangeSlider {
                            id: rangeSlider
                            x: 515
                            y: 187
                            second.value: 0.75
                            first.value: 0.25
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:10}D{i:9}D{i:25}D{i:24}D{i:37}D{i:36}D{i:8}D{i:2}
}
##^##*/

