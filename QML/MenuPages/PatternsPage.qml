import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML/Components" as AppComponents

PageTemplate {
    id: patternsPage
    objectName: "qrc:/QML/MenuPages/PatternsPage.qml"

    pageTitle: qsTr("Литература")
    buttonText: qsTr("+ Загрузить новый файл")
    emptyPageImageSource: "qrc:/Images/patterns_icon.png"
    emptyPageText:  qsTr("Ваша библиотека еще не заполнена. Загружайте новые файлы, чтобы сохранить полезные книги и статьи!")
    onButtonClicked: {
        Qt.openUrlExternally("content://com.android.externalstorage.documents/tree/primary%3ADownload")
    }
}
