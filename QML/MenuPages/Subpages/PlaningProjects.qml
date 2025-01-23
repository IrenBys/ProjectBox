import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/QML/Components" as AppComponents

Item {
    id: planningProjectsPage

    AppComponents.GridComponent {
        id: planningProjectsGrid
        anchors.fill: parent
        anchors.margins: 10
      }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }
}
