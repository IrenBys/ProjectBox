import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents
import "qrc:/QML"

Page {
    id: currentProjectsPage

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

    AppComponents.GridComponent {
        id: currentProjectsGrid
        anchors.fill: parent
        anchors.margins: 10
    }
}
