import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: buttonPanel
    width: parent.width
    height: 100

    property var buttons: []

    // Регистрация кнопок для их управления
    function registerButton(button) {
        buttons.push(button)
    }

    // Логика для активации кнопки
    function handleClick(clickedButton) {
        // Деактивируем все кнопки
        for (let i = 0; i < buttons.length; i++) {
            buttons[i].deactivate()
        }
        // Активируем только выбранную кнопку
        clickedButton.activate()
        // Испускаем сигнал, который будет обработан в main.qml
        clickedButton.buttonClicked(clickedButton)
    }

    // Панель с тремя кнопками
    Row {
        anchors.centerIn: parent
        spacing: 10

        // Кнопка 1
        SubpageButton {
            id: btn1
            buttonText: "Текущие"
            textColor: "white"
            backgroundColor: "#8A2BE2"
            Component.onCompleted: buttonPanel.registerButton(this)
            onButtonClicked: {
                console.log("Кнопка 1 нажата")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: buttonPanel.handleClick(btn1)
            }
        }

        // Кнопка 2
        SubpageButton {
            id: btn2
            buttonText: "Планируемые"
            textColor: "white"
            backgroundColor: "#8A2BE2"
            Component.onCompleted: buttonPanel.registerButton(this)
            onButtonClicked: {
                console.log("Кнопка 2 нажата")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: buttonPanel.handleClick(btn2)
            }
        }

        // Кнопка 3
        SubpageButton {
            id: btn3
            buttonText: "Завершенные"
            textColor: "white"
            backgroundColor: "#8A2BE2"
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
