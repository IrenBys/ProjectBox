import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

SubpageTemplate {
    id: newProjectPage
    //anchors.fill: parent
    objectName: "NewProject"
    subpageTitle: "Новый проект"

    property string projectName

    /*

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TextField {
            id: projectTitle
            placeholderText: qsTr("Название проекта")
            text: projectName
            onTextChanged: {
                toolbar.pageTitle = text
            }
        }

        TextField {
            id: startDate
            placeholderText: qsTr("Дата начала")
        }

        TextField {
            id: endDate
            placeholderText: qsTr("Дата окончания")
        }

        TextArea {
            id: notes
            placeholderText: qsTr("Заметки")
            Layout.fillHeight: true
        }

        Button {
            text: "Добавить фото"
            onClicked: console.log("Открыть галерею или камеру")
        }

    }*/
}
