import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/QML"
import "qrc:/QML/Components" as AppComponents

SubpageTemplate {
    id: newProjectPage
    objectName: "NewProject"
    subpageTitle: "Новый проект"

    property string projectName
    property string projectNameText: ""
    property date selectedDate: new Date()  // Храним выбранную дату

    property string dateBuffer: selectedDate.toLocaleDateString(Qt.locale(), "dd.MM.yyyy")

    property bool isKeyboardVisible: false
    property int keyboardHeight: 100


    // Следим за видимостью клавиатуры
    onIsKeyboardVisibleChanged: {
        if (isKeyboardVisible) {
            // Поднимаем содержимое на высоту клавиатуры
            dataColumn.y = -keyboardHeight;  // Поднимем на фиксированное число пикселей
        } else {
            // Когда клавиатура скрыта, возвращаем страницу обратно
            dataColumn.y = 0;
        }
    }

    // Подключаем сигнал изменения видимости клавиатуры
    Component.onCompleted: {
        InputMethod.visibleChanged.connect(function(visible) {
            isKeyboardVisible = visible;
        });
    }


    ScrollView {
        id: scrollView
        width: parent.width
        height: root.height
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical.policy: ScrollBar.ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        contentData: Column {
            id: dataColumn
            width: parent.width
            leftPadding: 20
            rightPadding: 20
            spacing: 10
            clip: true

            Rectangle {
                id: photoSelectButton
                width: root.width - 42
                height: width / 2
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/Images/photo_icon.png"
                    }

                    Text {
                        id:photoSelectText
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Добавить фото")
                        color: textColor
                        font: {
                            pixelSize: 16
                            family: "Roboto"
                            styleName: "normal"
                        }
                    }
                }

                SequentialAnimation {
                    id: blinkPhotoSelectButton
                    running: false
                    loops: 1
                    OpacityAnimator { target: photoSelectButton; to: 0.3; duration: 100 }
                    OpacityAnimator { target: photoSelectButton; to: 1.0; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Открыть выбор источника фото")
                        blinkPhotoSelectButton.running = true
                    }
                }
            }



            Text {
                topPadding: 20
                text: qsTr("ПРОЕКТ")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }

            Rectangle {
                id: projectMainInfo
                width: root.width - 42
                height: 200
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                ColumnLayout {
                    anchors.centerIn:  parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5

                    Label {
                        id: projectStatusLabel
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: projectMainInfo.width - 40
                        text: "Статус"
                        color: textColor
                        font {
                            pixelSize: 12
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        elide: "ElideRight"
                    }

                    AppComponents.ButtonPanel {
                        id: projectStatus
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        id: projectNameLabel
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: projectMainInfo.width - 40
                        text: "Название"
                        color: textColor
                        font {
                            pixelSize: 12
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        elide: "ElideRight"
                    }

                    TextField {
                        id: projectName
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: projectMainInfo.width - 40
                        Layout.preferredHeight: 40
                        text: projectNameText
                        placeholderText: (!focus && text.length === 0) ? "Введите название" : text
                        placeholderTextColor: textColor
                        color: textColor
                        font {
                            pixelSize: 12
                            family: "Roboto"
                            styleName: "normal"
                        }

                        background: Rectangle {
                            color: backgroundColor
                            border {
                                color: textColor
                                width: 1
                            }
                            radius: 6
                        }

                        onFocusChanged: {
                            if(focus){
                                isKeyboardVisible = true;
                            } else {
                                isKeyboardVisible = false;
                            }
                        }
                    }

                    Label {
                        id: projectDateLabel
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: projectMainInfo.width - 40
                        text: "Дата начала"
                        color: textColor
                        font {
                            pixelSize: 12
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        elide: "ElideRight"
                    }

                    TextField {
                        id: projectDate
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: projectMainInfo.width - 40
                        Layout.preferredHeight: 40
                        text: selectedDate.toLocaleDateString(Qt.locale(), "dd.MM.yyyy")
                        color: textColor
                        font {
                            pixelSize: 12
                            family: "Roboto"
                            styleName: "normal"
                        }

                        background: Rectangle {
                            color: backgroundColor
                            border {
                                color: textColor
                                width: 1
                            }
                            radius: 6
                        }

                        onFocusChanged: {
                            if(focus){
                                isKeyboardVisible = true;
                            } else {
                                isKeyboardVisible = false;
                            }
                        }

                        // Регулярное выражение для проверки даты (день, месяц, год)
                        property string datePattern: "^(0[1-9]|[12][0-9]|3[01])\\.(0[1-9]|1[0-2])\\.(\\d{4})$"

                        onTextChanged: {
                            var regex = new RegExp(datePattern);
                            var inputText = projectDate.text;

                            if (regex.test(inputText)) {
                                var dateParts = inputText.split(".");
                                var day = parseInt(dateParts[0], 10);
                                var month = parseInt(dateParts[1], 10) - 1; // Месяцы в JS начинаются с 0
                                var year = parseInt(dateParts[2], 10);

                                var date = new Date(year, month, day);

                                // Проверяем, соответствует ли введенная дата реальной
                                if (date.getDate() === day && date.getMonth() === month && date.getFullYear() === year) {
                                    selectedDate = date; // Если дата валидна, сохраняем ее
                                } else {
                                    projectDate.text = ""; // Если нет, очищаем поле
                                }
                            } else {
                                projectDate.text = ""; // Если формат неправильный, очищаем поле
                            }
                        }
                    }
                }
            }

            Text {
                topPadding: 20
                text: qsTr("ЛИТЕРАТУРА")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }

            Rectangle {
                id: addPatternButton
                width: root.width - 42
                height: 60
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                Text {
                    id:addPatternText
                    anchors.centerIn: parent
                    text: qsTr("Подключить файл из библиотеки")
                    color: textColor
                    font: {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                    }
                }

                SequentialAnimation {
                    id: blinkAddPatternButton
                    running: false
                    loops: 1
                    OpacityAnimator { target: addPatternButton; to: 0.3; duration: 100 }
                    OpacityAnimator { target: addPatternButton; to: 1.0; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Добавить PDF файл")
                        blinkAddPatternButton.running = true  // Запуск анимации мигания
                    }
                }
            }

            Text {
                topPadding: 20
                text: qsTr("МАТЕРИАЛЫ")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }

            Rectangle {
                id: addMaterialButton
                width: (root.width - 42) / 2
                height: 60
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                Text {
                    id:addMaterialText
                    anchors.centerIn: parent
                    text: qsTr("Добавить материал")
                    color: textColor
                    font: {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                    }
                }

                SequentialAnimation {
                    id: blinkAddMaterialButton
                    running: false
                    loops: 1
                    OpacityAnimator { target: addMaterialButton; to: 0.3; duration: 100 }
                    OpacityAnimator { target: addMaterialButton; to: 1.0; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Добавить PDF файл")
                        blinkAddPatternButton.running = true  // Запуск анимации мигания
                    }
                }
            }

            Text {
                topPadding: 20
                text: qsTr("ИНСТРУМЕНТЫ")
                color: textColor
                font {
                    pixelSize: 16
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
            }


            Rectangle {
                id: addToolButton
                width: (root.width - 42) / 2
                height: 60
                color: backgroundColor
                border {
                    color: textColor
                    width: 1
                }
                radius: 6

                Text {
                    id:addToolText
                    anchors.centerIn: parent
                    text: qsTr("Добавить инструмент")
                    color: textColor
                    font: {
                        pixelSize: 16
                        family: "Roboto"
                        styleName: "normal"
                    }
                }

                SequentialAnimation {
                    id: blinkAddToolButton
                    running: false
                    loops: 1
                    OpacityAnimator { target: addToolButton; to: 0.3; duration: 100 }
                    OpacityAnimator { target: addToolButton; to: 1.0; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Добавить PDF файл")
                        blinkAddPatternButton.running = true  // Запуск анимации мигания
                    }
                }
            }

            AppComponents.PageButton {
                id: saveNewButton
                height: 64
                width: root.width - 40
                //anchors.bottom: scrollView.bottom
                buttonText: qsTr("СОХРАНИТЬ")
                onClicked: {
                    console.log("Сохранить" + subpageTitle.text)
                    closePage()
                }
            }
        }
    }
}

