import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.example.Database 1.0

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

Item {
    id: gridComponent

    property int columns: 3

    ListModel {
        id: gridModel
        Component.onCompleted: {
            // Загружаем проекты из базы данных
            loadProjectsFromDatabase()
            // Добавляем кнопку "Добавить" в конец модели
            append({ display: qsTr("Добавить") })
        }
        // Функция для загрузки проектов из базы данных
        function loadProjectsFromDatabase() {
            var projects = DatabaseManager.getProjects();
            for (var i = 0; i < projects.length; i++) {
                append({ display: projects[i] });
            }
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
                        width: gridComponent.width / gridLayout.columns - gridLayout.columnSpacing * 0.75
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
                                    addItemPopup.open()  // Открываем Popup для добавления проекта
                                } else {
                                    console.log("Выбран проект: " + model.display)
                                    //root.openPage("qrc:/QML/MenuPages/Subpages/Project.qml")
                                    stackView.push("qrc:/QML/MenuPages/Subpages/Project.qml", { projectName: model.display })
                                    console.log("[main.qml]\tOpen page: qrc:/QML/MenuPages/Subpages/Project.qml")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    AppComponents.AddItemPopup {
        id: addItemPopup
        onItemAdded: (itemName) => {
            if (DatabaseManager.addProject(itemName)) {
                gridModel.insert(gridModel.count - 1, { display: itemName }) // Обновляем UI
            } else {
                console.log("Ошибка: Не удалось добавить проект в базу данных")
            }
        }
    }
}
