/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

// Import In-App Analytics QML-plugin
import Analytics 1.0

PageStackWindow {
    id: window

    property bool testMode: false
    property bool noBranding: false
    property bool iaa: true

    property variant analytics: analyticsId

    initialPage: MainPage { }
    showStatusBar: true
    showToolBar: true

    onTestModeChanged: console.debug("Test mode changed to " + testMode);
    onNoBrandingChanged: console.debug("No branding: " + noBranding);

    // In-App Analytics (IAA)
    Analytics {
        id: analyticsId
        connectionTypePreference: Analytics.AnyConnection
        loggingEnabled: (appSettings.analyticsEnabled === 2 && window.iaa === true) ? true : false
        minBundleSize: 1

        Component.onCompleted: {
            console.log("In-App Analytics: Initialized");
            analyticsId.initialize("1eb4b448b8419166421fa4ae439a6f7f", "WeatherForecast "+appVersion);
            delayedDlg.start();
        }
    }

    // Delayed timer for showing dialog for asking premission to use IAA
    Timer {
        id: delayedDlg
        interval: 2000
        onTriggered: {
            // Ask permission to start storing application usage information.
            // Permiossion is asked only once on application startup and user's answer is stored
            // into application settings.
            if (appSettings.analyticsEnabled === 0 && window.iaa === true) {
                console.log("In-App Analytics: Ask user permission when using API first time");
                // Show IAA terms page to the user
                pageStack.push(Qt.resolvedUrl("IAATermsPage.qml"));
            } else if (appSettings.analyticsEnabled === 1) {
                console.log("In-App Analytics: User was not allowed previously");
            } else if (appSettings.analyticsEnabled === 2) {
                console.log("In-App Analytics: User was allowed previously");
            }
        }
    }
}
