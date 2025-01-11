import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    width: 360
    height: 640

    // Экспортируем свойства для доступа к placeholderText
    property alias searchField: searchField.placeholderText
    property alias pageContent: pageContent

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5" // Цвет фона
        z: -1 // Помещаем фон позади всех остальных элементов
    }

    // Верхняя панель со стрелкой "Назад" и строкой поиска
    RowLayout {
        id: topBar
        width: parent.width
        height: 50
        spacing: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10

        // Стрелка "Назад"
        Image {
            id: backButton
            sourceSize.width: 30
            sourceSize.height: 30
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/Images/back_arrow_icon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Назад в главное меню")
                    root.parent.pop()
                }
            }
        }

        // Поле для поиска
        Rectangle {
            id: searchBar
            width: parent.width - backButton.width - 3 * topBar.spacing // Учитываем стрелку и отступы
            height: 40
            radius: 20
            color: "#FAEEDD"
            border.color: "#E5D9D0"  // Цвет границы
            border.width: 1  // Толщина границы
            Layout.fillWidth: true
            anchors.margins: 5

            RowLayout {
                anchors.fill: parent
                anchors.margins: 2
                spacing: 5


                // Поле ввода текста
                TextField {
                    id: searchField
                    Layout.fillWidth:true
                    placeholderText: qsTr("Поиск...")                    
                    font.pixelSize: 14
                    background: null
                    // Удаление текста при получении фокуса
                    onFocusChanged: {
                        if (focus) {
                            placeholderText = ""
                        }
                    }
                }

                // Значок лупы
                Image {
                    id: searchIcon
                    source: "qrc:/Images/search_icon.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Поиск запущен")
                            // Здесь можно добавить логику для поиска
                        }
                    }
                }

            }
        }
    }

    // Основное содержимое страницы
    Flickable {
        id: pageContent
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        contentWidth: width
        contentHeight: childrenRect.height
    }
}
