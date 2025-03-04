import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML/Components" as AppComponents

PageTemplate {
    id: projectsPage
    objectName: "ProjectsPage"

    pageTitle: qsTr("Привет, " + "пользователь" + "!")
    textTitle: qsTr("Вдохновение рядом – начинайте прямо сейчас!")
    buttonText: qsTr("+ Добавить новый проект")
    showTextTitle: true
    emptyPageImageSource: "qrc:/Images/projects_icon.png"
    emptyPageText: qsTr("Здесь появятся ваши проекты.\nДобавьте новый проект и начните работу!")
    onButtonClicked: {
        openPage("qrc:/QML/MenuPages/Subpages/NewProject.qml")
    }
}

