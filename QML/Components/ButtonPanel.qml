import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    id: buttonPanel
    width: parent.width
    height: 40

    // Внешнее значение выбранного статуса
    property string selectedStatus: "inProgress"

    // Список статусов с отображаемым текстом и кодом
    property var statusList: [
        { text: "Текущие", code: "inProgress" },
        { text: "Планируемые", code: "planned" },
        { text: "Завершенные", code: "completed" }
    ]

    property var buttons: []

    signal selectedValueChanged(string selectedValue)
    signal selectedTextChanged(string selectedText)

    function registerButton(button) {
        console.log("[registerButton] Зарегистрирована кнопка:", button.buttonText)
        buttons.push(button)
    }

    function getCodeByText(text) {
        console.log("[getCodeByText] Ищем код по тексту:", text)
        for (let i = 0; i < statusList.length; i++) {
            if (statusList[i].text === text) {
                console.log("[getCodeByText] Найден код:", statusList[i].code)
                return statusList[i].code
            }
        }
        console.log("[getCodeByText] Код не найден")
        return ""
    }

    function getTextByCode(code) {
        console.log("[getTextByCode] Ищем текст по коду:", code)
        for (let i = 0; i < statusList.length; i++) {
            if (statusList[i].code === code) {
                console.log("[getTextByCode] Найден текст:", statusList[i].text)
                return statusList[i].text
            }
        }
        console.log("[getTextByCode] Текст не найден")
        return ""
    }

    function handleClick(clickedButton) {
        console.log("[handleClick] Нажата кнопка:", clickedButton.buttonText)
        for (let i = 0; i < buttons.length; i++) {
            buttons[i].deactivate()
        }

        clickedButton.activate()
        clickedButton.buttonClicked(clickedButton)

        selectedStatus = getCodeByText(clickedButton.buttonText)
        console.log("[handleClick] Новый selectedStatus:", selectedStatus)

        selectedValueChanged(selectedStatus)
        selectedTextChanged(clickedButton.buttonText)
    }

    function setStatusByCode(statusCode) {
         console.log("[setStatusByCode] Устанавливаем статус по коду:", statusCode)
        const targetText = getTextByCode(statusCode)
        for (let i = 0; i < buttons.length; i++) {
            if (buttons[i].buttonText === targetText) {
                console.log("[setStatusByCode] Найдена подходящая кнопка:", targetText)
                handleClick(buttons[i])
                break
            }
        }
    }

    RowLayout {
        id: buttonRow
        spacing: 12

        Repeater {
            model: statusList

            SubpageButton {
                id: dynamicButton
                buttonText: modelData.text

                Component.onCompleted: buttonPanel.registerButton(this)

                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonPanel.handleClick(dynamicButton)
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("[Component.onCompleted] Инициализация панели со статусом:", selectedStatus)
        setStatusByCode(selectedStatus)
    }
}
