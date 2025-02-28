import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: footer
    color: "#FAEEDD"

    signal pageSelected(string page)

    property int selectedIndex: -1  // Индекс выбранной кнопки

    RowLayout {
        anchors.fill: parent

        Repeater {
            model: ListModel {
                ListElement { name: "Инструменты"; icon: "qrc:/Images/tools.png"; page: "qrc:/QML/MenuPages/ToolsPage.qml" }
                ListElement { name: "Литература"; icon: "qrc:/Images/patterns.png"; page: "qrc:/QML/MenuPages/PatternsPage.qml" }
                ListElement { name: "Проекты"; icon: "qrc:/Images/projects.png"; page: "qrc:/QML/MenuPages/ProjectsPage.qml" }
                ListElement { name: "Материалы"; icon: "qrc:/Images/storage.png"; page: "qrc:/QML/MenuPages/MaterialsPage.qml" }
                ListElement { name: "Профиль"; icon: "qrc:/Images/account_icon.png"; page: "qrc:/QML/MenuPages/ProfilePage.qml" }
            }

            delegate: Item {
                width: footer.width / 5
                height: footer.height

                Column {
                    anchors.centerIn: parent
                    spacing: 1

                    Image {
                        id: buttonImage
                        source: model.icon
                        width: 28
                        height: 28
                        anchors.horizontalCenter: parent.horizontalCenter

                        // Меняем непрозрачность в зависимости от того, выбрана ли кнопка
                        opacity: selectedIndex === index ? 1 : 0.5

                        // Анимация для мигания, когда кнопка выбрана
                        Behavior on opacity {
                            ColorAnimation {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }

                    Text {
                        text: model.name
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            pixelSize: 10
                            letterSpacing: -0.5
                        }
                        color: selectedIndex === index ? "#F3E0D0" : "#022027"
                        elide: Text.ElideRight

                        // Мигать цветом, когда кнопка выбрана
                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedIndex = index  // Устанавливаем индекс выбранной кнопки
                        footer.pageSelected(model.page)  // Открываем страницу
                    }
                }
            }
        }
    }
}
