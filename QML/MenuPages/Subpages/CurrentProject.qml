import QtQuick 2.15
import QtQuick.Controls 2.15


Item {
    id: currentProjectPage
    anchors.fill: parent


    Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5" // Цвет фона
        z: -1 // Помещаем фон позади всех остальных элементов
    }
}
