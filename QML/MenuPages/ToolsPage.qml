import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"
import "Subpages"
import "qrc:/QML/Components" as AppComponents


Page {
    id: toolsPage
    anchors.fill: parent
    objectName: "qrc:/QML/MenuPages/ToolsPage.qml"

    header: AppComponents.AppToolbar {
        id: toolBar
        pageTitle: qsTr("Инструменты")
        showTextTitle: false
        buttonText: qsTr("+ Добавить новый инструмент") 
        onNewItemCreated: {
            root.openPage("qrc:/QML/MenuPages/Subpages/NewTool.qml")
        }
        onSearchPerformed: function(query) {
            console.log("Поиск инструмента: " + query);
            // Здесь можно вызвать метод поиска, фильтрации и т. д.
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
            id: toolIcon
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.height * 0.1
            Layout.preferredHeight: root.height * 0.1
            source: "qrc:/Images/tools_icon.png"
            opacity: 0.8
        }

        Text {
            Layout.preferredWidth: root.width - 40
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Список инструментов пока пуст. Добавьте первый инструмент, чтобы он всегда был под рукой!")
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
