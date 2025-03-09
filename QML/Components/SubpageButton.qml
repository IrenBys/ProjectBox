import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/QML"

Rectangle {
    id: button
    width: buttonText.width + 20
    height: buttonText.font.pixelSize + 20
    color: isActive ? backgroundColor : inactiveColor
    border {
        color: isActive ? textColor : borderColor
        width: 1
    }
    radius: 6

    property alias buttonText: buttonText.text
    property color textColor: backgroundColor
    property color backgroundColor: textColor
    property color inactiveColor: backgroundColor  // Исправлено: теперь просто property
    property color borderColor: textColor  // Исправлено
    property bool isActive: false

    signal buttonClicked(SubpageButton clickedButton)

    function activate() {
        isActive = true
    }

    function deactivate() {
        isActive = false
    }

    Text {
        id: buttonText
        anchors.centerIn: parent
        text: qsTr("")
        color: isActive ? backgroundColor : textColor
        font {
            pixelSize: 10
            family: "Roboto"
            styleName: "normal"
        }
    }

    SequentialAnimation {
        id: blinkAnimation
        running: false
        loops: 1
        OpacityAnimator { target: buttonText; to: 0.3; duration: 100 }
        OpacityAnimator { target: buttonText; to: 1.0; duration: 100 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            blinkAnimation.running = true  // Запуск анимации мигания
            buttonClicked(button)  // Отправка сигнала
        }
    }
}
