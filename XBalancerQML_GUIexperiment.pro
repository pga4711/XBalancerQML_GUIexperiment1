QT += quick widgets charts
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

# To build a standalone executable exe with associated files.
false {
BUILD_TYPE = debug
CONFIG(release, debug|release): BUILD_TYPE = release
QML_PATH = $$PWD

win32 {
    TARGET_EXT = .exe
    DEPLOY_COMMAND = $$[QT_INSTALL_BINS]/windeployqt --$${BUILD_TYPE} --compiler-runtime --qmldir $$shell_quote($$shell_path($$QML_PATH))
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/$${BUILD_TYPE}/$${TARGET}$${TARGET_EXT}))
    QMAKE_POST_LINK += $${DEPLOY_COMMAND} $${DEPLOY_TARGET}
}
}
