import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: pageButton
    Layout.preferredHeight: 640/10
    Layout.preferredWidth: 360 - 20


    property alias buttonText: textButton.text
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
            pixelSize: 14
            weight: Font.Bold
        }
        color: "#022027"
        wrapMode: Text.Wrap
    }

    background: Rectangle {
        color:  "#FAEEDD"
        radius: 6
        border.color: "#E5D9D0"  // Цвет границы
        border.width: 1  // Толщина границы
    }

    onClicked: {
        pageButton.onClickedSignal()
    }
}

