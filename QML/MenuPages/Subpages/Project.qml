import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

Page {
    id: projectPage
    property string projectName

    header: AppComponents.AppToolbar {
        id: toolbar
        onBackClicked: {
            if (appWindow.stackView.depth > 1) {
                console.log("Возвращаемся назад")
                appWindow.stackView.pop()
            } else {
                console.log("Главная страница")
                appWindow.stackView.push("qrc:/QML/main.qml")
                appWindow.stackView.depth === 0
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        TextField {
            id: projectTitle
            placeholderText: qsTr("Название проекта")
            text: projectName
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

        Button {
            text: "Сохранить"
            onClicked: {
                console.log("Сохраняем проект: " + projectTitle.text)
                stackView.pop()
            }
        }
    }
}
