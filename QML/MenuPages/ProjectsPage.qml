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
        stackView.push(mainPageContent) // Устанавливаем начальное содержимое StackView
    }


    Component {
        id: mainPageContent

        Item {
            anchors.fill: parent

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10

                PageButton {
                    id: currentProjectButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Текущие")
                    onClicked: {
                        console.log("currentProjectButton")
                        stackView.push("qrc:/QML/MenuPages/Subpages/CurrentProject.qml")
                    }
                }

                PageButton {
                    id: finishedProjectsButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Завершенные")
                    onClicked: {
                        console.log("finishedProjectsButton")
                        stackView.push("qrc:/QML/MenuPages/Subpages/FinishedProjects.qml")
                    }
                }

                PageButton {
                    id: planningProjectsButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Планируемые")
                    onClicked: {
                        console.log("planningProjectsButton")
                        stackView.push("qrc:/QML/MenuPages/Subpages/PlaningProjects.qml")
                    }
                }
            }
        }
    }
}
