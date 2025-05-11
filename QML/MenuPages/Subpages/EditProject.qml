import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.Database 1.0

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents


SubpageTemplate {
    id: editProjectPage
    objectName: "EditProject"

    // Свойства, которые будут переданы при открытии страницы
    property int projectId: -1
    property string projectName: ""
    property string projectStatus: ""

    property int pageContentWidth: root.width - 40

    showMenuButton: true

    // Передаем projectName в заголовок
    subpageTitle: editProjectPage.projectName

    Component.onCompleted: {
        console.log("projectId в EditProject:", projectId)
        console.log("projectName в EditProject:", projectName)
        console.log("projectStatus в EditProject:", projectStatus)
    }

    AppComponents.ConfirmPopup {
        id: confirmClosePopup
        parent: editProjectPage
    }

    // Когда нажимают на иконку меню, открываем меню
    function menuButtonClicked() {
        var pos = editProjectPage.mapToGlobal(Qt.point(0, 0))
        var x = pos.x + editProjectPage.width - optionsMenu.width  // правая граница
        var y = pos.y                                          // верх элемента

        optionsMenu.popup(x, y)  // Показываем меню
    }

    Menu {
        id: optionsMenu

        MenuItem {
            text: qsTr("Редактировать")
            onTriggered: {
                console.log("Редактировать выбрано")
                // Переход на новую страницу с предзаполненными параметрами
                openPage("qrc:/QML/MenuPages/Subpages/NewProject.qml", {
                    projectId: projectId,
                    initialProjectName: projectName,
                    initialProjectStatus: projectStatus
                })
            }
        }

        MenuItem {
            text: qsTr("Удалить")
            onTriggered: {
                console.log("Удалить выбрано")
                confirmClosePopup.openWith(qsTr("Удалить проект \"" + projectName + "\"?"), function() {
                    console.log("Удаление подтверждено для проекта:", projectId)
                    DatabaseManager.deleteProject(projectId);
                    closePage();
                })
            }
        }
    }

    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height
        clip: true

        MouseArea {
            id: pageMouseArea
            anchors.fill: parent
            onClicked: {
                if (projectName.focus) {
                    projectName.focus = false
                }
            }
        }

        Column {
            id: dataColumn
            width: parent.width
            leftPadding: 20
            rightPadding: 20
            spacing: 10

            Label {
                id: projectStatusLabel
                width: pageContentWidth
                text: "Статус"
                color: textColor
                font.pixelSize: 12
                font.family: "Roboto"
                font.weight: Font.DemiBold
                elide: "ElideRight"
            }

            Rectangle {
                id: statusField
                width: statusFieldText.width + 20
                height: statusFieldText.font.pixelSize + 20
                color: textColor
                radius: 6

                Text {
                    id: statusFieldText
                    anchors.centerIn: parent
                    text: projectStatus
                    color: backgroundColor
                    font {
                        pixelSize: 12
                        family: "Roboto"
                        styleName: "normal"
                    }
                }
            }

        }
    }
}
