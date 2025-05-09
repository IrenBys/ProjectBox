import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"

// Попап подтверждения закрытия
Popup {
    id: confirmClosePopup
    modal: true
    focus: true
    width: parent.width * 0.8
    height: 150
    anchors.centerIn: parent
    background: Rectangle {
        color: backgroundColor
        radius: 10
    }

    property string messageText: qsTr("Вы уверены?")
    property var onAcceptCallback: null  // Функция, которую вызываем при "Да"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: messageText
            color: textColor
            font {
                pixelSize: 18
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            Layout.alignment: Qt.AlignHCenter
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Button {
                id: noButton
                text: qsTr("Нет")
                contentItem: Text {
                    id: btnText
                    text: parent.text
                    color: backgroundColor
                    font {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    color: buttonColor        // цвет фона (например, зелёный)
                    radius: 20               // скругление углов
                }
                onClicked: {
                    console.log("[ConfirmPopup] Нажата кнопка 'Нет'")
                    confirmClosePopup.close()
                }
            }

            Button {
                text: qsTr("Да")
                Layout.preferredWidth: noButton.implicitWidth
                contentItem: Text {
                    text: parent.text
                    color: backgroundColor
                    font {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    color: buttonColor        // цвет фона (например, зелёный)
                    radius: 20               // скругление углов
                }

                onClicked: {
                    console.log("[ConfirmPopup] Нажата кнопка 'Да'")
                    confirmClosePopup.close()
                    if (onAcceptCallback) {
                        console.log("[ConfirmPopup] Выполняется кастомный обработчик onAcceptCallback")
                        onAcceptCallback();
                    } else {
                        console.warn("[ConfirmPopup] onAcceptCallback не задан")
                    }
                }
            }
        }
    }


    function openWith(message, onAcceptFunc) {
        console.log("[ConfirmPopup] Открытие с сообщением:", message)
        messageText = message
        onAcceptCallback = onAcceptFunc
        open()
    }

    onVisibleChanged: {
        if (visible)
            console.log("[ConfirmPopup] Popup открыт")
        else
            console.log("[ConfirmPopup] Popup закрыт")
    }
}
