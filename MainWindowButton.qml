import QtQuick
import QtQuick.Controls

Button {
    id: mainWindowButton
    width: parent.width
    height: parent.height
    padding: textButton.height * 0.6

    property alias buttonText: textButton.text
    property string imageSource: ""
    signal onClickedSignal
    opacity: 1

    states: [
        State {
            name: "pressed"
            when: mainWindowButton.pressed
            PropertyChanges {
                target: mainWindowButton
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

    contentItem: Row {
        spacing: 5
        anchors.centerIn: parent

        Image {
            id: buttonIcon
            source: mainWindowButton.imageSource
            width: mainWindowButton.height * 0.5
            height: mainWindowButton.height * 0.5
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 5
        }

        Text {
            id: textButton
            text: qsTr("")
            font.bold: true
            color: "#382C1E"
            wrapMode: Text.Wrap
            width: parent.width * 0.8
        }
    }

    background: Rectangle {
        color:  "#FAEEDD"
        radius: 6
    }

    onClicked: {
        mainWindowButton.onClickedSignal()
    }
}
