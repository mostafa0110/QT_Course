import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 320
    height: 480
    title: "Calculator"
    color: "#1e1e1e"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        // 1. The Display Screen
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#2d2d2d"
            radius: 10

            Text {
                id: displayArea
                text: calcBackend.display
                color: "white"
                font.pixelSize: 54
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 15
            }
        }

        // 2. The Keypad Grid
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 4
            rowSpacing: 10
            columnSpacing: 10

            // 3. The Repeater generates 16 buttons automatically
            Repeater {
                model: ["7", "8", "9", "÷",
                        "4", "5", "6", "×",
                        "1", "2", "3", "-",
                        "C", "0", "=", "+"]

                CalcButton {
                    text: modelData
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    // Simple logic to color-code the buttons
                    property bool isOp: ["÷", "×", "-", "+", "="].includes(modelData)
                    property bool isClear: modelData === "C"

                    // Assign the color based on what type of button it is
                    btnColor: isOp ? "#ff9f0a" : (isClear ? "#ff453a" : "#4a4a4a")

                    onClicked: {
                        calcBackend.buttonPressed(modelData)
                    }
                }
            }
        }
    }

    // 4. Our custom, reusable button component
    component CalcButton: Button {
        id: control
        property color btnColor: "#4a4a4a" // Default gray color

        contentItem: Text {
            text: control.text
            color: "white"
            font.pixelSize: 26
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            radius: width / 2
            color: control.pressed ? Qt.darker(control.btnColor, 1.3) : control.btnColor
        }
    }
}
