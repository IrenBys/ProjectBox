import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640

    Column {
        anchors.centerIn: parent

        Row {
            spacing: 5

            MainWindowButton {
                id: buttonProject
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Проекты")
                imageSource: "qrc:/Images/projects_icon.png"
                onClicked: {
                    console.log("buttonProject")
                }
            }

            MainWindowButton {
                id: buttonPatterns
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Описания и инструкции")
                imageSource: "qrc:/Images/patterns_icon.png"
                onClicked: {
                    console.log("buttonPatterns")
                }
            }
        }

        Row {
            spacing: 5

            MainWindowButton {
                id: buttonMaterials
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Материалы")
                imageSource: "qrc:/Images/marerials_icon.png"
                onClicked: {
                    console.log("buttonMaterials")
                }
            }

            MainWindowButton {
                id: buttonTools
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Инструменты")
                imageSource: "qrc:/Images/tools_icon.png"
                onClicked: {
                    console.log("buttonTools")
                }
            }
        }
    }
}

