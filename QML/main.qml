import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640

    property alias stackView: stackView
    property int mainPageCount : 0
    property int buttonHeight: root.height/4
    property int buttonWidth: root.width/2 - 30


    function openPage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.push(page)
    }

    function closePage() {
        console.log("[main.qml]\tClose page: ", stackView.currentItem.objectName)
        if (stackView.depth > 1) {
            stackView.pop()
        } else {
            console.log("Главная страница")
            stackView.clear()  // Очистить стек
            stackView.push("qrc:/QML/main.qml")
        }
    }

    function replacePage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.replace(page)
    }


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
                columns: 2
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
                        openPage("qrc:/QML/MenuPages/ProjectsPage.qml")
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
                        openPage("qrc:/QML/MenuPages/PatternsPage.qml")
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
                        openPage("qrc:/QML/MenuPages/MaterialsPage.qml")
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
                        openPage("qrc:/QML/MenuPages/ToolsPage.qml")
                    }
                }
            }
        }
    }
}
