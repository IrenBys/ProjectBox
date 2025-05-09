import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import com.example.Database 1.0

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


    function openPage(page, props) {
        console.log("[main.qml]\tOpen page: " + page);

        stackView.push(page, props);  // передаем параметры
        Qt.callLater(updateFooter);
    }



    function closePage() {
        console.log("[main.qml] Close page: ", stackView.currentItem ? stackView.currentItem.objectName : "undefined");
        if (stackView.depth === 1) {
            console.log("Главная страница");
            stackView.replace("qrc:/QML/MenuPages/ProjectsPage.qml");
        } else {
            stackView.pop();
        }
        Qt.callLater(updateFooter);
    }

    function replacePage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        stackView.replace(page)
    }

    function updateFooter() {
        if (footerBar) {
            let noFooterPages = ["NewProject", "EditProject"];
            shouldShowFooter = !noFooterPages.includes(stackView.currentItem ? stackView.currentItem.objectName : "");
            footerBar.visible = shouldShowFooter;
            footerBar.height = shouldShowFooter ? 70 : 0;
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/QML/MenuPages/ProjectsPage.qml"

        onDepthChanged: {
            mainPageCount = depth;
            console.log("Количество страниц в стеке mainPageCount :", mainPageCount);

        }

        onCurrentItemChanged: {
            console.log("[main.qml] Текущая страница изменилась:", currentItem)
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
        width: root.width
        visible: shouldShowFooter
        height: 70
        onPageSelected: openPage(page)

    }

}
