/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constants.js" as Constants

// Import In-App Analytics QML-plugin
import Analytics 1.0

Page {
    id: mainPage

    Background {
        visible: !window.noBranding
    }

    // Create page session for In-App Analytics
    onStatusChanged: {
        if (status == PageStatus.Activating) {
            if (window.analytics.loggingEnabled)
                console.log("In-App Analytics: Start logging selected cities");
            window.analytics.start("MainPage");
        } else if (status == PageStatus.Deactivating) {
            if (window.analytics.loggingEnabled)
                console.log("In-App Analytics: Stop logging selected cities");
            window.analytics.stop("MainPage", Analytics.EndSession);
        }
    }

    // City delegate for the list view
    Component {
        id: delegate

        ListItem {
            id: listItem

            subItemIndicator: true

            Column {
                anchors.fill: listItem.paddingItem

                ListItemText {
                    mode: listItem.mode
                    role: "Title"
                    text: city
                    width: parent.width
                }

                ListItemText {
                    mode: listItem.mode
                    role: "SubTitle"
                    text: country
                    width: parent.width
                }
            }

            onClicked: {
                window.analytics.logEvent("MainPage", "Selected city :"+city, Analytics.ActivityLogEvent);
                window.pageStack.push(Qt.resolvedUrl("ForecastPage.qml"),
                                      { cityName: city ,
                                          testMode: window.testMode });

                // In-App Analytics: Save selected city
                if (window.analytics.loggingEnabled)
                    console.log("In-App Analytics: Save selected city : "+city);
            }
        }
    }

    // Branded header
    Component {
        id: headerLabel

        HeaderLabel {
            id: headerLabel
            width: mainPage.width
            imageSource: "qrc:///title-logo.png"
        }
    }

    // Basic header
    Component {
        id: listHeading

        ListHeading {
            id: myHeading

            ListItemText {
                anchors.fill: parent.paddingItem
                role: "Heading"
                text: qsTr("Weather forecast") + appSettings.emptyString;
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        header: window.noBranding ? listHeading : headerLabel
        model: CityModel {}
        delegate: delegate
    }

    ScrollDecorator {
        flickableItem: listView
    }

    tools: ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: {

                if (window.analytics.loggingEnabled)
                    console.log("In-App Analytics: Stop logging selected cities");
                window.analytics.stop("MainPage", Analytics.AppExit);

                Qt.quit();
            }
        }

        ToolButton {
            id: settingsButton
            flat: true
            iconSource: "qrc:///settings-icon.png"
            onClicked: window.pageStack.push("qrc:///SettingsPage.qml");
        }

        ToolButton {
            id: aboutButton
            flat: true
            iconSource: "qrc:///info-icon.png"
            onClicked: window.pageStack.push("qrc:///AboutPage.qml");
        }
    }
}
