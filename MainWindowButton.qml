import QtQuick
import QtQuick.Controls

Button {
    id: mainWindowButton
    property alias buttonText: textButton.text
    signal onClickedSignal

    width: parent.width
    height: parent.height
    padding: textButton.height * 0.6

    contentItem: Row {
        spacing: 5
        anchors.centerIn: parent

        Text {
            id: textButton
            anchors.verticalCenter: parent.top
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




