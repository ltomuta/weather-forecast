# Copyright (c) 2011-2014 Microsoft Mobile.

QT += network declarative xml
CONFIG += qt-components
TARGET = weatherforecast
VERSION = 1.1

HEADERS += \
    src/analyticsstub.h \
    src/appsettings.h \
    src/translate.h \
    src/wwosupport.h

SOURCES += \
    src/main.cpp \
    src/appsettings.cpp \
    src/translate.cpp \
    src/wwosupport.cpp

OTHER_FILES += \
    qml/common/* \
    loc/*.ts

RESOURCES += rsc/common.qrc

TRANSLATIONS += \
    loc/base_en.ts \
    loc/base_fi.ts \
    loc/base_ge.ts \
    loc/base_pl.ts


# The files containing the strings to be translated need to be defined under
# sources. Otherwise lupdate tool will not work properly.
for_lupdate {
    SOURCES += \
        qml/common/Constants.js \
        qml/common/*.qml \
        qml/harmattan/*.qml \
        qml/symbian/*.qml
}

# In test mode the application reads the weather data from a static file
# instead of using the network.
# Remove or comment out the following line to disable the test mode.
#DEFINES += TEST_MODE

# The implementation supports branding which uses custom list headings.
# To build the version without the customization, enable the following
# definition. Disabling branding is not supported on Harmattan.
#DEFINES += NO_BRANDING


# Enables In-App Analytics
# IAA is used to log used cities and languages in the application
#DEFINES += IAA


symbian {
    TARGET = WeatherForecast
    TARGET.UID3 = 0xE183855B

    # In-App Analytics enabled in the code
    contains(DEFINES, IAA) {
        message(In-App Analytics enabled in the code)
        TARGET.CAPABILITY = NetworkServices LocalServices ReadUserData \
                            WriteUserData UserEnvironment ReadDeviceData
    }

    # In-App Analytics disabled in the code
    !contains(DEFINES, IAA) {
        message(In-App Analytics disabled in the code)
        TARGET.CAPABILITY = NetworkServices
    }

    # Define In-App Analytics dependency
    analytics_deploy.pkg_prerules = "(0x20031574), 3, 0, 7, {\"In-App Analytics\"}"
    DEPLOYMENT += analytics_deploy

    HEADERS += src/componentloader.h
    SOURCES += src/componentloader.cpp
    RESOURCES += rsc/symbian.qrc

    # Publish the app version to source code.
    DEFINES += APP_VERSION=\"$$VERSION\"

    LIBS += -lcone -leikcore -lavkon

    ICON = icons/weatherforecast.svg

    OTHER_FILES += qml/symbian/*

    # Smart Installer package's UID
    # This UID is from the protected range and therefore the package will
    # fail to install if self-signed. By default qmake uses the unprotected
    # range value if unprotected UID is defined for the application and
    # 0x2002CCCF value if protected UID is given to the application
    #DEPLOYMENT.installer_header = 0x2002CCCF
}

contains(MEEGO_EDITION, harmattan) {
    DEFINES += Q_WS_HARMATTAN

    RESOURCES += rsc/harmattan.qrc
    OTHER_FILES += qml/harmattan/*

    DEFINES += APP_VERSION=\\\"$$VERSION\\\"

    target.path = /opt/$${TARGET}/bin
    desktopfile.files = $${TARGET}.desktop
    desktopfile.path = /usr/share/applications
    icon64.files += icons/$${TARGET}.png
    icon64.path = /usr/share/icons/hicolor/64x64/apps

    INSTALLS += \
        target \
        desktopfile \
        icon64
}

simulator {
    HEADERS += src/componentloader.h
    SOURCES += src/componentloader.cpp
    RESOURCES += rsc/symbian.qrc
    OTHER_FILES += qml/symbian/*

    # Publish the app version to source code.
    DEFINES += APP_VERSION=\\\"$$VERSION\\\"
}
