import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML/Components" as AppComponents

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640

    property string backgroundColor : "#F8F4FB"
    property string textColor : "#5F3475"
    property string buttonColor : "#2C2858"

    property alias stackView: stackView
    property int mainPageCount : 0
    property bool shouldShowFooter: true


    function openPage(page) {
        console.log("[main.qml]\tOpen page: " + page);
        stackView.push(page);
        Qt.callLater(updateFooter);
    }

    function closePage() {
        console.log("[main.qml] Close page: ", stackView.currentItem ? stackView.currentItem.objectName : "undefined");

        if (stackView.depth > 1) {
            stackView.pop();
        } else {
            console.log("Главная страница");
            stackView.clear();
            stackView.replace("qrc:/QML/MenuPages/ProjectsPage.qml");
        }

        Qt.callLater(updateFooter);
    }

    function replacePage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.replace(page)
    }

    function updateFooter() {
        if (stackView.currentItem) {
            console.log("Текущая страница:", stackView.currentItem.objectName);

            let noFooterPages = ["NewProject"];  // Страницы без футера
            shouldShowFooter = !noFooterPages.includes(stackView.currentItem.objectName);

            console.log("Футер отображается:", shouldShowFooter);
        } else {
            shouldShowFooter = true;
        }

        footerBar.visible = shouldShowFooter;
        footerBar.height = shouldShowFooter ? 70 : 0; // Скрываем и убираем место
        footerBar.updateActivePage(stackView.currentItem ? stackView.currentItem.objectName : "");
    }




    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/QML/MenuPages/ProjectsPage.qml"

        onDepthChanged: {
            mainPageCount = depth;
            console.log("Количество страниц в стеке mainPageCount :", mainPageCount);
            updateFooter();
        }
    }



    Component {
        id: mainMenu

        Item {
            anchors.fill: parent
        }
    }

    background: Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
        z: -1
    }

    footer: AppComponents.AppFooterBar {
        id: footerBar
        width: parent.width
        visible: shouldShowFooter
        height: 70
        onPageSelected: openPage(page)
    }

}


