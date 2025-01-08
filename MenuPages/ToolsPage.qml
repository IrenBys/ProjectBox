import QtQuick 2.15
import QtQuick.Controls 2.15

PageTemplate {
    title: "Проекты"

    Column {
        spacing: 10
        anchors.top: parent.top

        Repeater {
            model: 10 // Пример списка
            delegate: Rectangle {
                width: parent.width
                height: 40
                border.color: "#ccc"
                Text {
                    text: "Проект " + (index + 1)
                    anchors.centerIn: parent
                }
            }
        }
    }
}
