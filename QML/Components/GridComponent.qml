import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: gridComponent

    property int columns: 2  // Количество колонок в сеткеи

    ListModel {
        id: gridModel
        Component.onCompleted: {
            // Добавляем кнопку "Добавить" в конец модели
            append({ display: qsTr("Добавить") })
        }
    }

    ScrollView {
        anchors.fill: parent

        contentItem: Flickable {
            anchors.fill: parent
            contentWidth: gridLayout.width
            contentHeight: gridLayout.height
            clip: true

            GridLayout {
                id: gridLayout
                anchors.fill: parent
                columns: gridComponent.columns
                columnSpacing: 10
                rowSpacing: 10

                Repeater {
                    model: gridModel

                    delegate: Rectangle {
                        width: gridComponent.width / gridLayout.columns - gridLayout.columnSpacing/2
                        height: width
                        color:  "#FAEEDD"
                        radius: 6
                        border.color: "#E5D9D0"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: model.display  // Отображаем данные из модели
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (model.display === qsTr("Добавить")) {
                                    addItemDialog.open()  // Открываем Popup для добавления проекта
                                } else {
                                    console.log("Выбран проект: " + model.display)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Универсальный Popup для добавления элементов
    Popup {
        id: addItemDialog
        modal: true
        width: parent.width - 40
        height: 200
        focus: true

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: "#FFF"
            border.color: "#999"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                TextField {
                    id: itemNameInput
                    placeholderText: qsTr("Введите название элемента")
                    Layout.fillWidth: true
                }

                Button {
                    text: qsTr("Сохранить")
                    onClicked: {
                        if (itemNameInput.text.trim() !== "") {
                            // Добавляем новый элемент в модель
                            gridModel.insert(gridModel.count - 1, { display: itemNameInput.text.trim() })
                            itemNameInput.text = ""  // Очищаем поле ввода
                            addItemDialog.close()  // Закрываем Popup
                        } else {
                            console.log("Ошибка: Название элемента не может быть пустым")
                        }
                    }
                }
            }
        }
    }
}
