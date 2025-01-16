import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Button {
    id: mainWindowButton

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

    contentItem: ColumnLayout {

        Label {
            id: textButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("")
            font {
                pixelSize: 14
                weight: Font.Bold
            }
            color: "#022027"
            wrapMode: Text.Wrap
        }

        Image {
            Layout.preferredHeight: mainWindowButton.height * 0.4
            Layout.preferredWidth: mainWindowButton.height * 0.4
            Layout.alignment: Qt.AlignHCenter
            id: buttonIcon
            source: mainWindowButton.imageSource
        }
    }

    background: Rectangle {
        color:  "#FAEEDD"
        radius: 6
        border.color: "#E5D9D0"  // Цвет границы
        border.width: 1  // Толщина границы
    }

    onClicked: {
        mainWindowButton.onClickedSignal()
    }
}
