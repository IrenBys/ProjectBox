QT += quick

SOURCES += \
        main.cpp

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD/QML

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = QML

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ANDROID_ABIS = x86_64
android: include(C:/Users/User/AppData/Local/Android/Sdk/android_openssl/openssl.pri)

DISTFILES += \
    Images/marerials_icon.png \
    Images/materials_icon.png \
    Images/patterns_icon.png \
    Images/projects_icon.png \
    Images/tools_icon.png \
    MainWindowButton.qml \
    MenuPages/MaterialsPage.qml \
    MenuPages/PageButton.qml \
    MenuPages/PageTemplate.qml \
    MenuPages/PatternsPage.qml \
    MenuPages/ProjectPage.qml \
    MenuPages/ProjectsPage.qml \
    MenuPages/Subpages/CurrentProject.qml \
    MenuPages/ToolsPage.qml \
    QML/Components/GridComponent.qml \
    QML/Components/MainWindowButton.qml \
    QML/MainWindowButton.qml \
    QML/MenuPages/MaterialsPage.qml \
    QML/MenuPages/PageButton.qml \
    QML/MenuPages/PageTemplate.qml \
    QML/MenuPages/PatternsPage.qml \
    QML/MenuPages/ProjectsPage.qml \
    QML/MenuPages/Subpages/CurrentProject.qml \
    QML/MenuPages/Subpages/FinishedProjects.qml \
    QML/MenuPages/Subpages/PlaningProjects.qml \
    QML/MenuPages/ToolsPage.qml \
    QML/main.qml \
    main.qml
