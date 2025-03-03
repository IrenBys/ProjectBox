import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"
import "Subpages"
import "qrc:/QML/Components" as AppComponents


Page {
    id: projectsPage
    objectName: "ProjectsPage"

    header: AppComponents.AppToolbar {
        id: toolBar
        pageTitle: qsTr("Привет, " + "пользователь" + "!")
        textTitle: qsTr("Вдохновение рядом – начинайте прямо сейчас!")
        buttonText: qsTr("+ Добавить новый проект")
        showTextTitle: true
        onNewItemCreated: {
            root.openPage("qrc:/QML/MenuPages/Subpages/NewProject.qml")
        }
     }

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: "#F5FBF4"
        z: -1
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Image {
            id: projectIcon
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.height * 0.1
            Layout.preferredHeight: root.height * 0.1
            source: "qrc:/Images/projects_icon.png"
            opacity: 0.8
        }

        Text {
            Layout.preferredWidth: root.width - 40
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Здесь появятся ваши проекты")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#283F23"
            font {
                pixelSize: 16
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            wrapMode: Text.WordWrap
            elide: Text.ElideNone
            opacity: 0.8
        }
    }
}
