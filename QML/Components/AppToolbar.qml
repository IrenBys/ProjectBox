import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"

ToolBar {
    id: appToolbar
    width: root.width
    height: 180

    property alias pageTitle: pageTitle.text
    property alias textTitle: textTitle.text
    property alias buttonText: appToolbarButton.buttonText
    property bool showTextTitle: false
    signal newItemCreated
    signal searchPerformed(string query)

    background: Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            id: pageTitle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 20
            Layout.leftMargin: 20
            text: qsTr("")
            color: textColor
            font {
                pixelSize: 24
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }

        Text {
            id: textTitle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 20
            text: qsTr("")
            color: textColor
            font {
                pixelSize: 16
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            wrapMode: Text.WordWrap
            elide: Text.ElideNone
            visible: appToolbar.showTextTitle
        }

        SearchBar {
            id: searchComponent
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible: !appToolbar.showTextTitle

            onSearchClicked: function(query) {
                console.log("Выполняем поиск: " + query);
                appToolbar.searchPerformed(query);  // Вызываем сигнал поиска
            }
        }

        PageButton {
            id: appToolbarButton
            Layout.alignment: Qt.AlignHCenter
            buttonText: qsTr("")
            onClicked: {
                appToolbar.newItemCreated()
            }
        }
    }

}
