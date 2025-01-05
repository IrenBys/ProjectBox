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
                onClicked: {
                    console.log("buttonProject")
                }
            }

            MainWindowButton {
                id: buttonPatterns
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Описания и инструкции")
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
                onClicked: {
                    console.log("buttonMaterials")
                }
            }

            MainWindowButton {
                id: buttonTools
                width: appWindow.width/2 - 2 * parent.spacing
                height: appWindow.height/4
                buttonText: qsTr("Инструменты")
                onClicked: {
                    console.log("buttonTools")
                }
            }
        }
    }
}

