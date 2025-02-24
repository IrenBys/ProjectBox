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
    objectName: "qrc:/QML/MenuPages/ProjectsPage.qml"

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


    ColumnLayout {
        anchors.centerIn: parent
        anchors.margins: 10

        PageButton {
            buttonText: qsTr("Текущие проекты")
            onClicked: {
                root.openPage("qrc:/QML/MenuPages/Subpages/CurrentProjects.qml")
            }
        }

        PageButton {
            buttonText: qsTr("Завершенные проекты")
            onClicked: {
                root.openPage("qrc:/QML/MenuPages/Subpages/FinishedProjects.qml")
            }
        }

        PageButton {
            buttonText: qsTr("Планируемые проекты")
            onClicked: {
                root.openPage("qrc:/QML/MenuPages/Subpages/PlanningProjects.qml")
            }
        }
    }
}
