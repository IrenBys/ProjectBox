import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents

ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640

    property alias stackView: stackView
    property int mainPageCount : 0
    property int buttonHeight: appWindow.height/4
    property int buttonWidth: appWindow.width/2 - 30


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenu

        onDepthChanged: {
            mainPageCount = depth
            console.log("Количество страниц в стеке mainPageCount :", mainPageCount)
        }
    }

    Component {
        id: mainMenu

        Item {
            anchors.fill: parent

            GridLayout {
                anchors.centerIn: parent
                columns: 2  // Два столбца
                rows: 2
                columnSpacing: 20

                AppComponents.MainWindowButton {
                    id: buttonProject
                    Layout.preferredHeight: buttonHeight
                    Layout.preferredWidth: buttonWidth
                    buttonText: qsTr("Проекты")
                    imageSource: "qrc:/Images/projects_icon.png"
                    onClicked: {
                        console.log("buttonProject")
                        stackView.push("qrc:/QML/MenuPages/ProjectsPage.qml")
                    }
                }

                AppComponents.MainWindowButton {
                    id: buttonPatterns
                    Layout.preferredHeight: buttonHeight
                    Layout.preferredWidth: buttonWidth
                    buttonText: qsTr("Литература")
                    imageSource: "qrc:/Images/patterns_icon.png"
                    onClicked: {
                        console.log("buttonPatterns")
                        stackView.push("qrc:/QML/MenuPages/PatternsPage.qml")
                    }
                }

                AppComponents.MainWindowButton {
                    id: buttonMaterials
                    Layout.preferredHeight: buttonHeight
                    Layout.preferredWidth: buttonWidth
                    buttonText: qsTr("Материалы")
                    imageSource: "qrc:/Images/materials_icon.png"
                    onClicked: {
                        console.log("buttonMaterials")
                        stackView.push("qrc:/QML/MenuPages/MaterialsPage.qml")
                    }
                }

                AppComponents.MainWindowButton {
                    id: buttonTools
                    Layout.preferredHeight: buttonHeight
                    Layout.preferredWidth: buttonWidth
                    buttonText: qsTr("Инструменты")
                    imageSource: "qrc:/Images/tools_icon.png"
                    onClicked: {
                        console.log("buttonTools")
                        stackView.push("qrc:/QML/MenuPages/ToolsPage.qml")
                    }
                }
            }
        }
    }
}
