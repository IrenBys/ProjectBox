import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import "Subpages"

PageTemplate {
    id: projectsPage
    width: 360
    height: 640

    searchField: ("Искать проект...")

    Component.onCompleted: {
        pageStack.push(mainPageContent) // Устанавливаем начальное содержимое StackView
    }


    Component {
        id: mainPageContent

        Item {
            width: parent.width
            height: parent.height - 50


            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10

                PageButton {
                    id: currentProjectsButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Текущие")
                    onClicked: {
                        console.log("currentProjectButton")
                        pageStack.push("qrc:/QML/MenuPages/Subpages/CurrentProjects.qml")
                    }
                }

                PageButton {
                    id: finishedProjectsButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Завершенные")
                    onClicked: {
                        console.log("finishedProjectsButton")
                        pageStack.push("qrc:/QML/MenuPages/Subpages/FinishedProjects.qml")
                    }
                }

                PageButton {
                    id: planningProjectsButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Планируемые")
                    onClicked: {
                        console.log("planningProjectsButton")
                        pageStack.push("qrc:/QML/MenuPages/Subpages/PlaningProjects.qml")
                    }
                }
            }
        }
    }
}
