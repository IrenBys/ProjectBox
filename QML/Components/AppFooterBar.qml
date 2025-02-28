import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: footer
    width: parent.width
    height: 70
    color: "#FFF8F5"
    border.color: "#e5d9d0"
    border.width: 1
    //border.top: true

    property string activePage: "qrc:/QML/MenuPages/ProjectsPage.qml"

    signal pageSelected(string page)

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: ListModel {
                ListElement { name: "Проекты"; icon: "qrc:/Images/projects.png"; page: "qrc:/QML/MenuPages/ProjectsPage.qml" }
                ListElement { name: "Литература"; icon: "qrc:/Images/patterns.png"; page: "qrc:/QML/MenuPages/PatternsPage.qml" }
                ListElement { name: "Материалы"; icon: "qrc:/Images/storage.png"; page: "qrc:/QML/MenuPages/MaterialsPage.qml" }
                ListElement { name: "Инструменты"; icon: "qrc:/Images/tools.png"; page: "qrc:/QML/MenuPages/ToolsPage.qml" }
                ListElement { name: "Профиль"; icon: "qrc:/Images/account_icon.png"; page: "profile" }
            }

            delegate: Rectangle {
                width: footer.width / 5
                height: footer.height
                color: "transparent"

                property bool isActive: footer.activePage === model.page

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 2

                    Image {
                        source: model.icon
                        width: 28
                        height: 28
                        Layout.alignment: Qt.AlignHCenter
                        opacity: isActive ? 1.0 : 0.5
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    Text {
                        text: model.name
                        font.pixelSize: 10
                        color: "#022027"
                        Layout.alignment: Qt.AlignHCenter
                        opacity: isActive ? 1.0 : 0.5
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.opacity = 0.7
                    onReleased: parent.opacity = 1.0
                    onClicked: {
                        footer.activePage = model.page
                        footer.pageSelected(model.page)
                    }
                }
            }
        }
    }
}
