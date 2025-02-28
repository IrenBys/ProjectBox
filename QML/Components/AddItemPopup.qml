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
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true

            Label {
                text: qsTr("Добавить элемент")
                font.bold: true
                Layout.alignment: Qt.AlignLeft
            }

            Item {
                Layout.fillWidth: true
            }

            Image {
                id: cancelButton
                sourceSize.width: 30
                sourceSize.height: 30
                Layout.alignment: Qt.AlignRight
                source: "qrc:/Images/cancel_icon.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        confirmationDialog.open()
                    }
                }
            }
        }

        TextField {
            id: itemNameInput
            placeholderText: qsTr("Введите название элемента")
            Layout.fillWidth: true
        }

        Button {
            text: qsTr("Сохранить")
            Layout.fillWidth: true

            background: Rectangle {
                color:  "#FAEEDD"
                radius: 6
                border.color: "#E5D9D0"  // Цвет границы
                border.width: 1  // Толщина границы
            }

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

    Dialog {
        id: confirmationDialog
        title: qsTr("Подтверждение")
        modal: true
        standardButtons: Dialog.Yes | Dialog.No

        contentItem: Text {
            text: qsTr("Отменить создание нового проекта?")
            wrapMode: Text.WordWrap
        }

        onAccepted: {
            console.log("Пользователь нажал Yes (подтвердил отмену)")
            addItemDialog.close()
        }

        onRejected: {
            console.log("Пользователь нажал No (остался в диалоге)")
        }
    }
}

