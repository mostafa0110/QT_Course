import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1100
    height: 750
    visible: true
    title: "AutoVerse"
    color: "#12122a"

    // Custom properties to keep state
    property bool appReady: false

    // Splash Loader
    Loader {
        id: splashLoader
        anchors.fill: parent
        source: "SplashScreen.qml"
        active: !appReady
        onLoaded: {
            item.finished.connect(function() {
                appReady = true;
                mainContent.visible = true;
            });
        }
    }

    // Main Content
    Item {
        id: mainContent
        anchors.fill: parent
        visible: false

        // Custom Header
        Rectangle {
            id: headerBar
            width: parent.width
            height: 72
            anchors.top: parent.top
            color: "#1a1a3e"

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#0f0c29" }
                GradientStop { position: 0.5; color: "#1a1a3e" }
                GradientStop { position: 1.0; color: "#0f0c29" }
            }
            border.color: "#2a2a5e"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 20

                Text {
                    text: "🚗 AutoVerse"
                    color: "#e0e0ff"
                    font.pixelSize: 22
                    font.bold: true
                    font.letterSpacing: 3
                }

                Item { Layout.fillWidth: true } // spacer

                // Nav Buttons
                Row {
                    spacing: 10
                    NavButton {
                        text: "🏠 Home"
                        active: stackView.currentItem && stackView.currentItem.objectName === "home"
                        onClicked: stackView.replace("Home.qml")
                    }
                    NavButton {
                        text: "🖼️ Gallery"
                        active: stackView.currentItem && stackView.currentItem.objectName === "gallery"
                        onClicked: stackView.replace("Gallery.qml")
                    }
                    NavButton {
                        text: "ℹ️ About"
                        active: stackView.currentItem && stackView.currentItem.objectName === "about"
                        onClicked: stackView.replace("About.qml")
                    }
                }

                Item { Layout.fillWidth: true } // spacer

                Text {
                    text: "🌡 26°C"
                    color: "#facc15"
                    font.pixelSize: 15
                    font.bold: true
                }

                Text {
                    id: clockText
                    color: "#8888bb"
                    font.pixelSize: 13
                }
            }
        }

        StackView {
            id: stackView
            anchors.top: headerBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            initialItem: "Home.qml"

            replaceEnter: Transition {
                PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
            }
            replaceExit: Transition {
                PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
            }
        }
    }

    // Clock Timer
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clockText.text = new Date().toLocaleString(Qt.locale(), "ddd, dd MMM yyyy  hh:mm:ss");
        }
    }

    // A lightweight reusable inline component for your navigation buttons
    component NavButton: Button {
        id: ctrl
        property bool active: false

        implicitHeight: 40
        implicitWidth: implicitContentWidth + 56

        contentItem: Text {
            text: ctrl.text
            color: ctrl.active ? "#ffffff" : (ctrl.hovered ? "#b0b0ff" : "#8888bb")
            font.pixelSize: 14
            font.bold: true
            font.letterSpacing: 1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            radius: 20
            color: ctrl.active ? "transparent" : (ctrl.hovered ? "#1c1c40" : "transparent")
            border.color: ctrl.active ? "transparent" : (ctrl.hovered ? "#3a3a7e" : "#2a2a5e")
            border.width: ctrl.active ? 0 : 2

            // Active state gradient overlay
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                visible: ctrl.active

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#667eea" }
                    GradientStop { position: 1.0; color: "#764ba2" }
                }
            }
        }
    }
}
