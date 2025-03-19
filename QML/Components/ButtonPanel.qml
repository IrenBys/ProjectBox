import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import "qrc:/QML"

Item {
    id: buttonPanel
    width: parent.width
    height: btn1.height

    property var buttons: []

    function registerButton(button) {
        buttons.push(button)
    }

    function handleClick(clickedButton) {
        for (let i = 0; i < buttons.length; i++) {
            buttons[i].deactivate()
        }
        clickedButton.activate()
        clickedButton.buttonClicked(clickedButton)
    }

    // Панель с тремя кнопками
    RowLayout {
        anchors.centerIn: parent

        SubpageButton {
            id: btn1
            buttonText: "Текущие"
            Component.onCompleted: buttonPanel.registerButton(this)
            onButtonClicked: {
                console.log("Кнопка 1 нажата")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: buttonPanel.handleClick(btn1)
            }
        }

        SubpageButton {
            id: btn2
            buttonText: "Планируемые"
            Component.onCompleted: buttonPanel.registerButton(this)
            onButtonClicked: {
                console.log("Кнопка 2 нажата")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: buttonPanel.handleClick(btn2)
            }
        }

        SubpageButton {
            id: btn3
            buttonText: "Завершенные"
            Component.onCompleted: buttonPanel.registerButton(this)
            onButtonClicked: {
                console.log("Кнопка 3 нажата")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: buttonPanel.handleClick(btn3)
            }
        }
    }

    // По умолчанию активируем первую кнопку
    Component.onCompleted: {
        buttonPanel.handleClick(btn1)
    }
}
