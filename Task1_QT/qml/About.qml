import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    objectName: "about"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "ℹ️"
            font.pixelSize: 56
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "About AutoVerse"
            color: "#e0e0ff"
            font.pixelSize: 32
            font.bold: true
            font.letterSpacing: 2
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            width: 200
            height: 2
            color: "#667eea"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Version 1.0.0 (QML Edition)"
            color: "#667eea"
            font.pixelSize: 14
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "AutoVerse is a premium car gallery application\nshowcasing an exclusive collection of vehicles.\n\nBrowse through our curated selection of sports cars,\nluxury sedans, SUVs, and classic automobiles.\nEach vehicle card provides detailed information\nincluding color, type, and current availability."
            color: "#9999cc"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            lineHeight: 1.6
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.preferredHeight: 20 }

        // Developer Info Card
        Rectangle {
            width: 400
            height: 120
            color: "#1c1c40"
            border.color: "#2a2a5e"
            border.width: 1
            radius: 16
            Layout.alignment: Qt.AlignHCenter

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8

                Text { text: "👨‍💻  Developer"; color: "#b0b0ff"; font.pixelSize: 16; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                Text { text: "Mostafa"; color: "#8888bb"; font.pixelSize: 14; Layout.alignment: Qt.AlignHCenter }
                Text { text: "ITI — Qt Course, Task 1"; color: "#6666aa"; font.pixelSize: 13; Layout.alignment: Qt.AlignHCenter }
            }
        }

        Item { Layout.fillHeight: true }

        Text {
            text: "© 2026 AutoVerse. All rights reserved."
            color: "#4a4a7a"
            font.pixelSize: 11
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
