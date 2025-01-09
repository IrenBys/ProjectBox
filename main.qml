import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640
    color: "#FFF8F5"

    property string currentPage: ""

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenu
    }

    Component {
        id: mainMenu

        Item {
            width: parent.width
            height: parent.height

            Column {
                anchors.centerIn: parent

                Row {
                    spacing: 5

                    MainWindowButton {
                        id: buttonProject
                        buttonText: qsTr("Проекты")
                        imageSource: "qrc:/Images/projects_icon.png"
                        onClicked: {
                            console.log("buttonProject")
                            stackView.push("qrc:/MenuPages/ProjectsPage.qml")
                        }
                    }

                    MainWindowButton {
                        id: buttonPatterns
                        buttonText: qsTr("Литература")
                        imageSource: "qrc:/Images/patterns_icon.png"
                        onClicked: {
                            console.log("buttonPatterns")
                            stackView.push("qrc:/MenuPages/PatternsPage.qml")
                        }
                    }
                }

                Row {
                    spacing: 5

                    MainWindowButton {
                        id: buttonMaterials
                        buttonText: qsTr("Материалы")
                        imageSource: "qrc:/Images/materials_icon.png"
                        onClicked: {
                            console.log("buttonMaterials")
                            stackView.push("qrc:/MenuPages/MaterialsPage.qml")
                        }
                    }

                    MainWindowButton {
                        id: buttonTools
                        buttonText: qsTr("Инструменты")
                        imageSource: "qrc:/Images/tools_icon.png"
                        onClicked: {
                            console.log("buttonTools")
                            stackView.push("qrc:/MenuPages/ToolsPage.qml")
                        }
                    }
                }
            }
        }
    }


}
