QT += qml quick core

SOURCES += \
        datasource.cpp \
        main.cpp \
        rootcontext.cpp \
        user.cpp \
        vmdatamodel.cpp

RESOURCES += \
            qml/qml.qrc \
            pictures.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    datasource.h \
    rootcontext.h \
    user.h \
    vmdatamodel.h

DEFINES += DESKTOP#TABLET
#DEFINES += TEST
