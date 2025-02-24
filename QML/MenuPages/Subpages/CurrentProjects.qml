import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents
import "qrc:/QML"

Page {
    id: currentProjectsPage
    objectName: "qrc:/QML/MenuPages/Subpages/CurrentProjects.qml"

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }

    header: AppComponents.AppToolbar {
        id: toolbar
        onBackClicked: {
            root.closePage()
        }
    }

    AppComponents.GridComponent {
        id: currentProjectsGrid
        anchors.fill: parent
        anchors.margins: 10
    }
}
