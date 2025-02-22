import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "Subpages"
import "qrc:/QML/Components" as AppComponents
import "qrc:/QML"

Page {
    id: projectsPage
    width: 360
    height: 640

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }

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
        anchors.centerIn: parent
        anchors.margins: 10

        PageButton {
            buttonText: qsTr("Текущие проекты")
            onClicked: {
                stackView.push("qrc:/QML/MenuPages/Subpages/CurrentProjects.qml")
            }
        }

        PageButton {
            buttonText: qsTr("Завершенные проекты")
            onClicked: stackView.push("qrc:/QML/MenuPages/Subpages/FinishedProjects.qml")
        }

        PageButton {
            buttonText: qsTr("Планируемые проекты")
            onClicked: stackView.push("qrc:/QML/MenuPages/Subpages/PlanningProjects.qml")
        }
    }
}
