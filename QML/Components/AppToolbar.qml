import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ToolBar {
    id: appToolbar
    width: parent.width
    height: 60

    property alias pageTitle: pageTitle.text  // Заголовок страницы
    property alias searchText: searchField.text
    property bool showSearch: true  // По умолчанию показываем строку поиска
    signal backClicked()  // Сигнал для обработки "Назад"

    background: Rectangle {
        color: "#FAEEDD"
    }

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

        // Заголовок страницы (отображается, если строка поиска скрыта)
        Text {
            id: pageTitle
            text: "Название страницы"  // По умолчанию текст заголовка
            font.pixelSize: 16
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignVCenter
            visible: !appToolbar.showSearch  // Показывать, когда строка поиска скрыта
        }

        // Поле поиска
        Rectangle {
            id: searchBar
            Layout.fillWidth: true
            height: 40
            radius: 20
            color: "#FFF8F5"
            border.color: "#E5D9D0"
            border.width: 1
            visible: appToolbar.showSearch  // Скрываем, если нужно

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
