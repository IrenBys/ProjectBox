import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

PageTemplate {
    id: projectsPage
    width: 360
    height: 640

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: pageContent
    }

    Component {
        id: pageContent

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
                        //stackView.push("qrc:/MenuPages/ProjectsPage.qml")
                    }
                }

                PageButton {
                    id: finishedProjectButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Завершенные")
                    onClicked: {
                        console.log("finishedProjectButton")
                        //stackView.push("qrc:/MenuPages/ProjectsPage.qml")
                    }
                }

                PageButton {
                    id: planningProjectButton
                    Layout.alignment: Qt.AlignHCenter
                    buttonText: qsTr("Планируемые")
                    onClicked: {
                        console.log("planningProjectButton")
                        //stackView.push("qrc:/MenuPages/ProjectsPage.qml")
                    }
                }
            }
        }

    }


}
