import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    objectName: "gallery"

    ListModel {
        id: carModel
        ListElement { name: "Veloce GT"; colorStr: "Red"; type: "Sports Sedan"; avail: "In Stock"; img: "qrc:/images/car1.png" }
        ListElement { name: "Titan Explorer"; colorStr: "Silver"; type: "SUV"; avail: "In Stock"; img: "qrc:/images/car2.png" }
        ListElement { name: "Volt EV"; colorStr: "Blue"; type: "Electric Sedan"; avail: "Pre-Order"; img: "qrc:/images/car3.png" }
        ListElement { name: "Shadow RS"; colorStr: "Black"; type: "Luxury Coupe"; avail: "Limited"; img: "qrc:/images/car4.png" }
        ListElement { name: "Trail Boss"; colorStr: "White"; type: "Pickup Truck"; avail: "In Stock"; img: "qrc:/images/car5.png" }
        ListElement { name: "Heritage 60"; colorStr: "Green"; type: "Classic Sports"; avail: "Sold Out"; img: "qrc:/images/car6.png" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        Text {
            text: "🏎️  Car Gallery"
            color: "#e0e0ff"
            font.pixelSize: 28
            font.bold: true
            font.letterSpacing: 2
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Explore our premium collection — hover to highlight, click for details"
            color: "#7777aa"
            font.pixelSize: 13
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.preferredHeight: 10 }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            // Left Arrow
            Button {
                id: leftArrow
                text: "◀"
                implicitWidth: 48
                implicitHeight: 48
                contentItem: Text {
                    text: parent.text
                    color: leftArrow.hovered ? "#ffffff" : "#b0b0ff"
                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: leftArrow.pressed ? "#667eea" : (leftArrow.hovered ? "#3a3a7e" : "#2a2a5e")
                    radius: 24
                    border.color: leftArrow.hovered ? "#667eea" : "#3a3a7e"
                    border.width: 2
                }
                onClicked: {
                    let newIdx = Math.max(0, carousel.currentIndex - 1)
                    carousel.currentIndex = newIdx
                    carousel.positionViewAtIndex(newIdx, ListView.Contain)
                }
            }

            // Carousel
            ListView {
                id: carousel
                Layout.fillWidth: true
                Layout.fillHeight: true
                orientation: ListView.Horizontal
                spacing: 20
                model: carModel
                clip: true
                snapMode: ListView.SnapToItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                
                delegate: Item {
                    width: 280
                    height: 320

                    Rectangle {
                        id: cardBg
                        anchors.fill: parent
                        color: hoverHandler.hovered ? "#2a2a5e" : "#1c1c40"
                        radius: 16
                        border.color: hoverHandler.hovered ? "#667eea" : "#2a2a5e"
                        border.width: 2
                        
                        scale: hoverHandler.hovered ? 1.05 : 1.0
                        Behavior on scale { NumberAnimation { duration: 150 } }

                        // QML doesn't have a direct DropShadow element without importing graphical effects
                        // We simulate it gracefully with the scale and border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 10

                            Rectangle {
                                color: "#1e1e3a"
                                radius: 12
                                Layout.fillWidth: true
                                Layout.preferredHeight: 220
                                
                                Image {
                                    anchors.fill: parent
                                    anchors.margins: 8
                                    source: model.img
                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                    mipmap: true
                                }
                            }

                            Text {
                                text: model.name
                                color: "#d0d0ff"
                                font.pixelSize: 16
                                font.bold: true
                                font.letterSpacing: 1
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }

                        HoverHandler { id: hoverHandler }
                        TapHandler {
                            onTapped: {
                                detailDialog.carData = {
                                    name: model.name,
                                    colorStr: model.colorStr,
                                    type: model.type,
                                    avail: model.avail,
                                    img: model.img
                                }
                                detailDialog.open()
                            }
                        }
                    }
                }
            }

            // Right Arrow
            Button {
                id: rightArrow
                text: "▶"
                implicitWidth: 48
                implicitHeight: 48
                contentItem: Text {
                    text: parent.text
                    color: rightArrow.hovered ? "#ffffff" : "#b0b0ff"
                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: rightArrow.pressed ? "#667eea" : (rightArrow.hovered ? "#3a3a7e" : "#2a2a5e")
                    radius: 24
                    border.color: rightArrow.hovered ? "#667eea" : "#3a3a7e"
                    border.width: 2
                }
                onClicked: {
                    let newIdx = Math.min(carousel.count - 1, carousel.currentIndex + 1)
                    carousel.currentIndex = newIdx
                    carousel.positionViewAtIndex(newIdx, ListView.Contain)
                }
            }
        }
    }

    Popup {
        id: detailDialog
        width: 480
        height: 520
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property var carData: ({})

        background: Rectangle {
            radius: 16
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1a1a3e" }
                GradientStop { position: 1.0; color: "#0f0c29" }
            }
            border.color: "#2a2a5e"
            border.width: 1
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 14

            Rectangle {
                color: "#12122a"
                radius: 12
                Layout.fillWidth: true
                Layout.preferredHeight: 260

                Image {
                    anchors.fill: parent
                    anchors.margins: 10
                    source: detailDialog.carData.img || ""
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    mipmap: true
                }
            }

            Text {
                text: detailDialog.carData.name || ""
                color: "#e0e0ff"
                font.pixelSize: 26
                font.bold: true
                font.letterSpacing: 2
                Layout.alignment: Qt.AlignHCenter
            }

            GridLayout {
                columns: 2
                columnSpacing: 10
                rowSpacing: 10
                Layout.alignment: Qt.AlignHCenter

                Text { text: "Color:"; color: "#7777aa"; font.pixelSize: 14; font.bold: true; Layout.alignment: Qt.AlignRight }
                Text { text: detailDialog.carData.colorStr || ""; color: "#b0b0ff"; font.pixelSize: 14 }

                Text { text: "Type:"; color: "#7777aa"; font.pixelSize: 14; font.bold: true; Layout.alignment: Qt.AlignRight }
                Text { text: detailDialog.carData.type || ""; color: "#b0b0ff"; font.pixelSize: 14 }

                Text { text: "Status:"; color: "#7777aa"; font.pixelSize: 14; font.bold: true; Layout.alignment: Qt.AlignRight }
                Text {
                    text: detailDialog.carData.avail || ""
                    font.pixelSize: 14
                    color: {
                        if (text === "In Stock") return "#4ade80"
                        if (text === "Pre-Order") return "#facc15"
                        if (text === "Limited") return "#fb923c"
                        return "#f87171"
                    }
                }
            }

            Item { Layout.fillHeight: true }

            Button {
                id: closeBtn
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: 140
                implicitHeight: 40
                contentItem: Text {
                    text: "Close"
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                    font.letterSpacing: 1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    radius: 20
                    color: closeBtn.hovered ? "#764ba2" : "#667eea"
                }
                onClicked: detailDialog.close()
            }
        }
    }
}
