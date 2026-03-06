import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    objectName: "home"
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "🚗"
            font.pixelSize: 80
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Welcome to AutoVerse QML"
            color: "#e0e0ff"
            font.pixelSize: 38
            font.bold: true
            font.letterSpacing: 3
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Your Premium Car Gallery Experience"
            color: "#8888bb"
            font.pixelSize: 16
            font.letterSpacing: 2
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.preferredHeight: 20 }

        RowLayout {
            spacing: 20
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                model: [
                    { icon: "🏎️", title: "Premium Cars", desc: "Explore top-tier vehicles" },
                    { icon: "🔍", title: "Detailed Info", desc: "Color, type & availability" },
                    { icon: "✨", title: "Interactive", desc: "Fluid QML animations" }
                ]

                Rectangle {
                    width: 220
                    height: 160
                    color: "#1c1c40"
                    border.color: "#2a2a5e"
                    border.width: 1
                    radius: 16

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 8
                        
                        Text { text: modelData.icon; font.pixelSize: 36; Layout.alignment: Qt.AlignHCenter }
                        Text { text: modelData.title; color: "#b0b0ff"; font.pixelSize: 15; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        Text { text: modelData.desc; color: "#6666aa"; font.pixelSize: 12; Layout.alignment: Qt.AlignHCenter }
                    }
                }
            }
        }

        Item { Layout.preferredHeight: 30 }

        Button {
            id: exploreBtn
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: 220
            implicitHeight: 48
            
            contentItem: Text {
                text: "Explore Gallery →"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                font.letterSpacing: 1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                radius: 24
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: exploreBtn.hovered ? "#764ba2" : "#667eea" }
                    GradientStop { position: 1.0; color: exploreBtn.hovered ? "#667eea" : "#764ba2" }
                }
            }

            onClicked: {
                // Find stackView and replace (requires object hierarchy search, safer to just replace from main if available)
                // Assuming stackView id is accessible, or use parent approach.
                // It is accessible if not placed in an independent context.
                if (typeof stackView !== "undefined") {
                    stackView.replace("Gallery.qml")
                }
            }
        }
    }
}
