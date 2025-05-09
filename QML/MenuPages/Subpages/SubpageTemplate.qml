import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

Page {
    id:subpageTemplate
    background: Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
        z: -1
    }

    property alias subpageTitle: subpageTitle.text
    // Свойства для управления видимостью кнопок
    property bool showMenuButton: false


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

            Image {
                id: editPageImage
                Layout.alignment: Qt.AlignVCenter
                Layout.rightMargin: 20
                visible: showMenuButton
                source: "qrc:/Images/menu.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("editPageImage clicked")
                        menuButtonClicked()
                    }
                }
            }
        }
    }    
}
