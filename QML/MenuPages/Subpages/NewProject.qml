import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

import com.example.Database

SubpageTemplate {
    id: newProjectPage
    objectName: "NewProject"
    subpageTitle: "Новый проект"

    property string projectId: ""
    property string initialProjectName: ""
    property string initialProjectStatus: ""

    Component.onCompleted: {
        if (initialProjectName !== "") {
            projectName.text = initialProjectName
        }

        if (initialProjectStatus !== "") {
            projectStatus.selectedStatus = initialProjectStatus
        }

        console.log("NewProject.qml: параметры загружены", projectId, initialProjectName, initialProjectStatus)
    }

    property string projectNameText: ""
    property int pageContentWidth: root.width - 40

    function saveProject() {
        const name = projectName.text.trim()
        const status = projectStatus.selectedStatus

        console.log("Проект " + name + " сохранен в статусе: " + status)
        DatabaseManager.addProject(name, status)
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
                id: projectNameLabel
                width: pageContentWidth
                text: "Название"
                color: textColor
                font.pixelSize: 12
                font.family: "Roboto"
                font.weight: Font.DemiBold
                elide: "ElideRight"
            }

            TextField {
                id: projectName
                width: pageContentWidth
                height: 40
                text: projectNameText
                placeholderText: (!focus && text.length === 0) ? "Введите название" : ""
                placeholderTextColor: textColor
                color: textColor

                font.pixelSize: 12
                font.family: "Roboto"

                background: Rectangle {
                    color: backgroundColor
                    border.color: textColor
                    border.width: 1
                    radius: 6
                }

                onEditingFinished: {
                    projectNameText = text.trim()
                    console.log("Финальное имя проекта: " + projectNameText)
                }
            }

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

            AppComponents.ButtonPanel {
                id: projectStatus
                width: pageContentWidth

                onSelectedValueChanged: (selectedValue) => {
                    console.log("Выбран статус: " + selectedValue)
                }
            }

            AppComponents.PageButton {
                id: saveNewButton
                height: 64
                width: pageContentWidth
                buttonText: qsTr("СОХРАНИТЬ")

                onClicked: {
                    const name = projectName.text.trim()
                    const status = projectStatus.selectedStatus

                    if (name === "") {
                        console.log("Ошибка: Название проекта не может быть пустым")
                        projectName.background.border.color = "red"
                    } else if (!status || status === "") {
                        console.log("Ошибка: Статус проекта не может быть пустым")
                    } else {
                        saveProject()
                        closePage()
                    }
                }
            }
        }
    }
}
