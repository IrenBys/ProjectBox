import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

Page {
    id:subpageTemplate

    property alias subpageTitle: subpageTitle.text

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
        z: -1
    }

    header: ToolBar {
        height: 70

        background: Rectangle {
            color: backgroundColor
        }

        RowLayout {
            anchors.fill: parent

            Image {
                id: closePageImage
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 20
                source: "qrc:/Images/close_icon.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closePage()
                    }
                }
            }

            Text {
                id: subpageTitle
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 20
                verticalAlignment: Text.AlignVCenter
                text: qsTr("")
                color: textColor
                font {
                    pixelSize: 20
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }
        }
    }

    ScrollView {
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        contentData: Column {
            id: dataColumn
            width: parent.width
            leftPadding: 20
            rightPadding: 20
            spacing: 10
            clip: true

            Rectangle {
                id: photoSelectButton
                width: root.width - 42
                height: width / 2
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6


                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/Images/photo_icon.png"
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Добавить фото")
                        color: textColor
                        font: {
                            pixelSize: 16
                            family: "Roboto"
                            styleName: "normal"
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Открыть выбор источника фото")
                }
            }

            Text {
                topPadding: 20
                text: qsTr("ЛИТЕРАТУРА")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }

            Rectangle {
                width: root.width - 42
                height: 60
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                Text {
                    anchors.centerIn: parent
                    text: qsTr("Подключить файл из библиотеки")
                    color: textColor
                    font: {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Добавить PDF файл")
                }
            }

            Text {
                topPadding: 20
                text: qsTr("ОСНОВНАЯ ИНФОРМАЦИЯ")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }

            Rectangle {
                width: root.width - 42
                height: width
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6


                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10

                    AppComponents.ButtonPanel {
                        anchors.centerIn: parent
                        width: parent.width
                        height: 100
                    }
                }
            }


            AppComponents.PageButton {
                id: saveNewButton
                height: 64
                width: root.width - 40
                buttonText: qsTr("СОХРАНИТЬ")
                onClicked: {
                    console.log("Сохранить" + subpageTitle.text)
                    closePage()
                }
            }
        }
    }
}
