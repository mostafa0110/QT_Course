import QtQuick
import QtQuick.Controls

Item {
    id: splashScreen
    anchors.fill: parent

    signal finished()

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0f0c29" }
            GradientStop { position: 0.5; color: "#302b63" }
            GradientStop { position: 1.0; color: "#24243e" }
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "🚗"
                font.pixelSize: 80
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "AutoVerse QML"
                color: "#e0e0ff"
                font.pixelSize: 42
                font.bold: true
                font.letterSpacing: 4
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Premium Car Gallery"
                color: "#8888bb"
                font.pixelSize: 16
                font.letterSpacing: 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item { height: 20; width: 1 } // spacing

            Rectangle {
                id: progressBarContainer
                width: 300
                height: 6
                color: "#1a1a3e"
                radius: 3
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true

                Rectangle {
                    id: progressBarFill
                    height: parent.height
                    width: 0
                    radius: 3
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#667eea" }
                        GradientStop { position: 1.0; color: "#764ba2" }
                    }

                    NumberAnimation on width {
                        id: progressAnim
                        to: progressBarContainer.width
                        duration: 2000
                        easing.type: Easing.InOutQuad
                        onFinished: splashScreen.finished()
                    }
                }
            }

            Text {
                id: statusText
                text: "Initializing..."
                color: "#6666aa"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            let pct = progressBarFill.width / progressBarContainer.width;
            if (pct < 0.25) statusText.text = "Initializing systems...";
            else if (pct < 0.5) statusText.text = "Loading car database...";
            else if (pct < 0.75) statusText.text = "Preparing gallery assets...";
            else if (pct < 0.95) statusText.text = "Starting engine...";
            else statusText.text = "Ready!";
        }
    }

    Component.onCompleted: {
        progressAnim.start();
    }
}
