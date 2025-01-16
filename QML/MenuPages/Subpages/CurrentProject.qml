import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML/Components" as AppComponents

Item {
    id: currentProjectPage

    AppComponents.GridComponent {
        id: projectGrid
        anchors.fill: parent
        anchors.margins: 10
        //Layout.alignment: Qt.AlignHCenter
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }
}
