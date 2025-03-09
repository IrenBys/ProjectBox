import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"

Button {
    id: pageButton
    Layout.preferredHeight: 64
    Layout.preferredWidth: root.width - 40

    property alias buttonText: textButton.text
    property color buttonTextColor: backgroundColor
    property color pageButtonColor: buttonColor

    // Новые свойства с дефолтными значениями
    property int fontSize: 18
    property int fontWeight: Font.DemiBold

    signal onClickedSignal

    opacity: 1

    states: [
        State {
            name: "pressed"
            when: pageButton.pressed
            PropertyChanges {
                target: pageButton
                opacity: 0.5
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "pressed"
            reversible: true
            NumberAnimation {
                properties: "opacity"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    Label {
        id: textButton
        anchors.centerIn: parent
        text: qsTr("")

        font {
            pixelSize: pageButton.fontSize   // Используем переменную
            family: "Roboto"
            styleName: "normal"
            weight: pageButton.fontWeight   // Используем переменную
        }
        color: buttonTextColor
        wrapMode: Text.Wrap
    }

    background: Rectangle {
        color: pageButtonColor
        radius: 6
    }

    onClicked: {
        pageButton.onClickedSignal()
    }
}


