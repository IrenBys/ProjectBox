import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML/Components" as AppComponents

PageTemplate {
    id: toolsPage
    objectName: "qrc:/QML/MenuPages/ToolsPage.qml"

    pageTitle: qsTr("Инструменты")
    buttonText: qsTr("+ Добавить новый инструмент")
    emptyPageImageSource: "qrc:/Images/tools_icon.png"
    emptyPageText:  qsTr("Список инструментов пока пуст. Добавьте первый инструмент, чтобы он всегда был под рукой!")
    onButtonClicked: {
        openPage("qrc:/QML/MenuPages/Subpages/NewTool.qml")
    }
}

