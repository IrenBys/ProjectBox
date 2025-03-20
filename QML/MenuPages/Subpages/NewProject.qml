import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

SubpageTemplate {
    id: newProjectPage
    objectName: "NewProject"
    subpageTitle: "Новый проект"

    property string projectNameText: ""
    property int pageContentWidth: root.width - 40
    property bool isKeyboardVisible: false
    property string projectStatus: ""


    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height
        clip: true

        MouseArea {
            id: pageMouseArea
            anchors.fill: parent
            onClicked: {
                projectName.focus = false;
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
                font {
                    pixelSize: 12
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
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
                selectByMouse: true
                font {
                    pixelSize: 12
                    family: "Roboto"
                    styleName: "normal"
                }

                background: Rectangle {
                    color: backgroundColor
                    border {
                        color: projectName.text.trim() === "" && projectName.focus ? "red" : textColor
                        width: 1
                    }
                    radius: 6
                }

                onFocusChanged: isKeyboardVisible = focus;
                onPressed: focus = true;

                onEditingFinished: focus = false
            }

            Label {
                id: projectStatusLabel
                width: pageContentWidth
                text: "Статус"
                color: textColor
                font {
                    pixelSize: 12
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                elide: "ElideRight"
            }

            AppComponents.ButtonPanel {
                id: projectStatus
                width: pageContentWidth
                onSelectedValueChanged: {
                    projectStatus = selectedValue;
                }
            }

            AppComponents.PageButton {
                id: saveNewButton
                height: 64
                width: pageContentWidth
                buttonText: qsTr("СОХРАНИТЬ")
                onClicked: {
                    if (projectName.text.trim() === "") {
                        console.log("Ошибка: Название проекта не может быть пустым");
                        projectName.background.border.color = "red";
                    } else {
                        saveProject();
                        closePage();
                    }
                }
            }
        }
    }

    function saveProject() {
        var projectData = {
            name: projectName.text,
            status: projectStatus,
        };
        console.log("Проект сохранен:", projectData);
    }
}
