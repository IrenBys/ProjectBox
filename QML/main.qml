import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640

    property alias stackView: stackView
    property int mainPageCount : 0
    property int buttonHeight: root.height/4
    property int buttonWidth: root.width/2 - 30


    function openPage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.push(page)
    }

    function closePage() {
        console.log("[main.qml]\tClose page: ", stackView.currentItem.objectName)
        if (stackView.depth > 1) {
            stackView.pop()
        } else {
            console.log("Главная страница")
            stackView.clear()  // Очистить стек
            stackView.push("qrc:/QML/main.qml")
        }
    }

    function replacePage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.replace(page)
    }

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: "#FFF8F5"
        z: -1
    }


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenu

        onDepthChanged: {
            mainPageCount = depth
            console.log("Количество страниц в стеке mainPageCount :", mainPageCount)
        }
    }

    Component {
        id: mainMenu

        Item {
            anchors.fill: parent


        }
    }

    AppComponents.AppFooterBar {
        id: footerBar
        width: parent.width
        height: 70
        anchors.bottom: parent.bottom
        onPageSelected: openPage(page)  // Переход на выбранную страницу
    }



}
