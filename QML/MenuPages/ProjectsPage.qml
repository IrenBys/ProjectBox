import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.example.Database 1.0
import com.example.ProjectModel 1.0

import "qrc:/QML"

PageTemplate {
    id: projectsPage
    objectName: "ProjectsPage"

    pageTitle: qsTr("Привет, " + "пользователь" + "!")
    textTitle: qsTr("Вдохновение рядом – начинайте прямо сейчас!")
    buttonText: qsTr("+ Добавить новый проект")
    showTextTitle: true
    emptyPageImageSource: "qrc:/Images/projects_icon.png"
    emptyPageText: qsTr("Здесь появятся ваши проекты.\nДобавьте новый проект и начните работу!")
    onButtonClicked: {
        openPage("qrc:/QML/MenuPages/Subpages/NewProject.qml")
    }

    function getStatusText(code) {
        const map = {
            "inProgress": "Текущие",
            "planned": "Планируемые",
            "completed": "Завершенные"
        }
        return map[code] || code
    }

    // Используем зарегистрированную модель
    ProjectModel {
        id: projectModel
    }

    ListView {
        id: projectList
        width: parent.width - 40
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 40
        spacing: 10
        anchors.margins: 20

        model: projectModel  // Используем модель, которая будет обновляться в QML

        delegate: Rectangle {
            width: parent.width
            height: projectsPage.height / 3 - footerBar.height
            color: backgroundColor
            radius: 8
            border.color: textColor
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10

                Text {
                    id: modelNameText
                    text: model.name
                    Layout.fillWidth: true
                    color: textColor
                    font {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                }

                Text {
                    id: modelStatusText
                    text: getStatusText(model.status)
                    color: textColor
                    font {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Переход на страницу редактирования проекта " +
                                model.id + " " +
                                modelNameText.text + " " +
                                modelStatusText.text)
                    openPage("qrc:/QML/MenuPages/Subpages/EditProject.qml", {
                        projectId: model.id,
                        projectName: modelNameText.text,
                        projectStatus: modelStatusText.text
                    });
                }
            }
        }        
    }

    // Подключаем к сигналам DatabaseManager
    Connections {
        target: DatabaseManager

        function onProjectAdded(success, msg) {
            console.log("===> QML получил onProjectAdded:", success, msg);
            if (success) {
                console.log("Загружаем проекты после добавления.");
                DatabaseManager.loadProjects();  // Обновление проектов
            } else {
                console.error("Ошибка добавления проекта:", msg);
            }
        }
        function onProjectsReadyForQml(projects) {
            console.log("===> QML получил проекты:", projects);
            projectModel.loadProjectsFromVariant(projects);
            if (projects.length > 0) {
                emptyPageVisible = false;
            } else {
                emptyPageVisible = true;
            }
        }
        function onProjectDeleted(success, msg) {
            console.log("===> QML получил onProjectDeleted:", success, msg);
            if (success) {
                console.log("Проект успешно удалён, обновляем список проектов...");
                DatabaseManager.loadProjects();  // ← это обновит данные в модели
            } else {
                console.error("Ошибка при удалении проекта:", msg);
            }
        }
    }
}
