import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: searchBar
    height: 40
    width: parent.width - 40
    radius: 20
    color: "#F5FBF4"

    property alias text: searchField.text  // Свойство для доступа к тексту поиска
    signal searchClicked(string searchText)  // Сигнал при нажатии на кнопку поиска

    border {
        color: "#283F23"
        width: 1
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        TextField {
            id: searchField
            Layout.fillWidth: true
            placeholderText: qsTr("Поиск...")
            font.pixelSize: 14
            background: null
        }

        Image {
            id: searchIcon
            source: "qrc:/Images/search_icon.png"
            sourceSize.width: 20
            sourceSize.height: 20
            Layout.alignment: Qt.AlignVCenter
            Layout.rightMargin: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Поиск: " + searchField.text);
                    searchBar.searchClicked(searchField.text);  // Вызываем сигнал
                }
            }
        }
    }
}
