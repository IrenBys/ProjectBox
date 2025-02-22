import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import "qrc:/QML/Components" as AppComponents

Page {
    property StackView stackView

    GridLayout {
        anchors.centerIn: parent
        columns: 2
        rows: 2
        columnSpacing: 20

        AppComponents.MainWindowButton {
            Layout.preferredHeight: appWindow.buttonHeight
            Layout.preferredWidth: appWindow.buttonWidth
            buttonText: qsTr("Проекты")
            imageSource: "qrc:/Images/projects_icon.png"
            onClicked: {
                console.log("buttonProject")
                stackView.push("qrc:/QML/MenuPages/ProjectsPage.qml")
            }
        }

        AppComponents.MainWindowButton {
            Layout.preferredHeight: appWindow.buttonHeight
            Layout.preferredWidth: appWindow.buttonWidth
            buttonText: qsTr("Литература")
            imageSource: "qrc:/Images/patterns_icon.png"
            onClicked: {
                console.log("buttonPatterns")
                if(stackView)
                {
                  stackView.push("qrc:/QML/MenuPages/PatternsPage.qml",  { stackView: stackView })
                } else {
                    console.error("Ошибка: stackView не передан")
                }

            }
        }

        AppComponents.MainWindowButton {
            Layout.preferredHeight: appWindow.buttonHeight
            Layout.preferredWidth: appWindow.buttonWidth
            buttonText: qsTr("Материалы")
            imageSource: "qrc:/Images/materials_icon.png"
            onClicked: {
                console.log("buttonMaterials")
                stackView.push("qrc:/QML/MenuPages/MaterialsPage.qml",  { stackView: stackView })
            }
        }

        AppComponents.MainWindowButton {
            Layout.preferredHeight: appWindow.buttonHeight
            Layout.preferredWidth: appWindow.buttonWidth
            buttonText: qsTr("Инструменты")
            imageSource: "qrc:/Images/tools_icon.png"
            onClicked: {
                console.log("buttonTools")
                stackView.push("qrc:/QML/MenuPages/ToolsPage.qml",  { stackView: stackView })
            }
        }
    }
}
