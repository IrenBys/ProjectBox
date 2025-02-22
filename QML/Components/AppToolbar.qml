import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: appToolbar
    width: parent.width
    height: 50

    property alias searchText: searchField.text
    signal backClicked()  // Объявляем сигнал

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Кнопка "Назад"
        Image {
            id: backButton
            sourceSize.width: 30
            sourceSize.height: 30
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/Images/back_arrow_icon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: toolbar.backClicked()
            }
        }

        // Поле поиска
        Rectangle {
            id: searchBar
            Layout.fillWidth: true
            height: 40
            radius: 20
            color: "#FAEEDD"
            border.color: "#E5D9D0"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Поиск...")
                    font.pixelSize: 14
                    background: null
                }

                Image {
                    id: searchIcon
                    source: "qrc:/Images/search_icon.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Поиск: " + searchField.text)
                    }
                }
            }
        }
    }
}
