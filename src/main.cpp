/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include <QtGui/QApplication>
#include <QtDeclarative>

#include "appsettings.h"
#include "translate.h"
#include "wwosupport.h"

#ifndef Q_WS_HARMATTAN
    #include "componentloader.h"
#endif

#ifdef Q_WS_SIMULATOR
    #include "analyticsstub.h"
#endif

const int SplashScreenDelay = 3000; // In milliseconds


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);       

    AppSettings settings;
    WWOSupport wwoSupport;

    QDeclarativeView view;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);

    QObject::connect(view.engine(), SIGNAL(quit()), &app, SLOT(quit()));

    QDeclarativeContext *context = view.rootContext();

    context->setContextProperty("appSettings", &settings);
    context->setContextProperty("wwoSupport", &wwoSupport);

    // Expose the application version to QML
    app.setApplicationVersion(APP_VERSION);
    context->setContextProperty("appVersion", app.applicationVersion());

#ifdef Q_OS_SYMBIAN
    view.setAttribute(Qt::WA_NoSystemBackground);
#endif

#ifdef Q_WS_SIMULATOR
    qmlRegisterType<Analytics>("Analytics", 1, 0, "Analytics");
#endif

#ifndef Q_WS_HARMATTAN
    view.setSource(QUrl("qrc:///SplashScreen.qml"));
    view.showFullScreen();

    // Hides splash screen and shows application main screen after few seconds
    // Test mode will be set by the component loader if necessary
    ComponentLoader componentLoader(view);
    componentLoader.load(SplashScreenDelay);
#else
    // No splash screen required on Harmattan
    view.setSource(QUrl("qrc:///main.qml"));

#ifdef TEST_MODE
    QObject *rootObject = dynamic_cast<QObject*>(view.rootObject());
    if (rootObject) {
        rootObject->setProperty("testMode", true);
    }
#endif // TEST_MODE

    view.showFullScreen();
#endif // If defined Q_WS_HARMATTAN

    return app.exec();
}
