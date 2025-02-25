import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: addItemDialog
    modal: true
    width: parent ? parent.width - 40 : 300
    height: 200
    focus: true

    property alias text: itemNameInput.text
    signal itemAdded(string itemName)

    background: Rectangle {
        color: "#FFF"
        radius: 10
        border.color: "#999"
        border.width: 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TextField {
            id: itemNameInput
            placeholderText: qsTr("Введите название элемента")
            Layout.fillWidth: true
        }

        Button {
            text: qsTr("Сохранить")
            Layout.fillWidth: true
            onClicked: {
                if (itemNameInput.text.trim() !== "") {
                    itemAdded(itemNameInput.text.trim()) // Отправляем сигнал
                    itemNameInput.text = "" // Очищаем поле ввода
                    addItemDialog.close() // Закрываем Popup
                } else {
                    console.log("Ошибка: Название элемента не может быть пустым")
                }
            }
        }
    }
}
