import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/QML"
import "Subpages"
import "qrc:/QML/Components" as AppComponents


Page {
    id: pageTemplate
    property alias pageTitle: toolBar.pageTitle
    property alias textTitle: toolBar.textTitle
    property alias buttonText: toolBar.buttonText
    property alias emptyPageImageSource: emptyPageImage.source
    property alias emptyPageText: emptyPageTxt.text
    property bool showTextTitle: false
    signal buttonClicked

    background: Rectangle {
        id: background
        anchors.fill: parent
        color:backgroundColor
        z: -1
    }

    header: AppComponents.AppToolbar {
        id: toolBar
        pageTitle: qsTr("")
        textTitle: qsTr("")
        buttonText: qsTr("")
        showTextTitle: pageTemplate.showTextTitle
        onNewItemCreated: {
            pageTemplate.buttonClicked()
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Image {
            id: emptyPageImage
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.height * 0.2
            Layout.preferredHeight: root.height * 0.2
            source: ""
            opacity: 0.8
        }

        Text {
            id: emptyPageTxt
            Layout.preferredWidth: root.width - 40
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            text: emptyPageText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: textColor
            font {
                pixelSize: 16
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            wrapMode: Text.WordWrap
            elide: Text.ElideNone
            opacity: 0.8
        }
    }
}
