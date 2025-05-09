import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Menu {
    id: dynamicOptionsMenu

    // Свойства для передачи пунктов меню
    property var menuItems: []  // Список элементов меню

    // Генерация пунктов меню на основе списка menuItems
    Repeater {
        model: dynamicOptionsMenu.menuItems

        MenuItem {
            text: modelData.text  // Текст пункта
            onTriggered: {
                console.log("[DynamicOptionsMenu] Выбран пункт:", modelData.text)
                dynamicOptionsMenu.menuItemClicked(modelData)
            }
        }
    }

    // Сигнал для обработки выбора пункта меню
    signal menuItemClicked(var item)
}
