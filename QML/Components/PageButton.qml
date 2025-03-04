import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"

Button {
    id: pageButton
    Layout.preferredHeight: root.height/10
    Layout.preferredWidth: root.width - 40


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
            pixelSize: 18
            family: "Roboto"
            styleName: "normal"
            weight: Font.DemiBold
        }
        color: "#F8F4FB"
        wrapMode: Text.Wrap
    }

    background: Rectangle {
        color:  "#2C2858"
        radius: 6
    }

    onClicked: {
        pageButton.onClickedSignal()
    }
}

