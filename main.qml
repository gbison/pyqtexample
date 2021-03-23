import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.2

Window {
    width: 640
    height: 480
    visible: true
    color: "#595656"
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
    title: "Python GUI Example For Ci2"
    maximumWidth: 640
    maximumHeight: 480
    minimumHeight: 480
    minimumWidth: 640

    property string filePath: ""

    // Removes title bar and ability to move window
    flags: Qt.Window | Qt.FramelessWindowHint

    Pane {
        id: windowPane
        x: 5
        y: 5
        width: 630
        height: 470

        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            nameFilters: ["*"]
            selectFolder: false
            onAccepted: {
                fileField.text = fileDialog.fileUrl.toString().toLowerCase(
                            ).substring(8, fileDialog.fileUrl.length)
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
            width: 606
            height: 99
            title: qsTr("Group Box")

            Button {
                id: readButton
                x: 15
                y: 18
                text: "Read"
                onClicked: {


                    /* File is stored in class var
                        Then push to text box */
                    main.openFile(filePath)
                }
            }

            Button {
                id: writeButton
                x: 241
                y: 18
                text: "Write"
                onClicked: {
                    main.sayMyName("Bryan")
                }
            }

            Button {
                id: exitButton
                x: 474
                y: 18
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
            width: 606
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
            width: 606
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
                }
            }
        }
    }
    Connections {
        /* this target ties the backend to the front end, you must call this target to access QT Slots (METHODS!) */
        target: main


        /* Callback method for reading data into the textBox, we cant pass data directly back and forth, must use
        call back signals. Thus the signal needs to match the signal variable in the backend but must begin with 'on'*/
        function onReadText(text) {
            textArea.text = text
        }

        function onReadPath(text) {
            filePath = text
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/

