import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML/Components" as AppComponents

PageTemplate {
    id: materialsPage
    objectName: "qrc:/QML/MenuPages/MaterialsPage.qml"
    pageTitle: qsTr("Материалы")
    buttonText: qsTr("+ Добавить новый материал")
    emptyPageImageSource: "qrc:/Images/materials_icon.png"
    emptyPageText:  qsTr("Здесь будут ваши материалы.\nДобавьте новый, чтобы начать наполнять коллекцию!")
    onButtonClicked: {
        openPage("qrc:/QML/MenuPages/Subpages/NewMaterial.qml")
    }
}
