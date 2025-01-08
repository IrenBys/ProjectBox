import QtQuick
import QtQuick.Controls

Button {
    id: mainWindowButton
    width: appWindow.width/2 - 2 * parent.spacing
    height: appWindow.height/4
    spacing: parent.spacing

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

    contentItem: Column {
        anchors.centerIn: mainWindowButton
        spacing: mainWindowButton.spacing * 2  // отступы между текстом и изображением

        Label {
            id: textButton
            text: qsTr("")
            font {
                pixelSize: 0.125 * parent.height
                weight: Font.Bold
            }
            color: "#022027"
            wrapMode: Text.Wrap
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            width: mainWindowButton.height * 0.4
            height: mainWindowButton.height * 0.4
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: buttonIcon
                source: mainWindowButton.imageSource
                width: parent.width
                height: parent.height
            }
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
