/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import "Constants.js" as Constants

Page {
    id: mainPage

    property bool testModeEnabled: false

    Background { }

    // List containing the cities
    ListView {
        id: listView

        anchors.fill: parent

        header: HeaderLabel {
            //title: qsTr("Weather forecast") + appSettings.emptyString;
            imageSource: "qrc:///title-logo.png"
        }

        model: CityModel {}

        delegate: ListItem {
            width: parent ? parent.width : 480
            text: city

            onClicked: {
                window.pageStack.push(Qt.resolvedUrl("ForecastPage.qml"),
                                      { cityName: city,
                                        testMode: testModeEnabled });
            }
        }
    }

    ScrollDecorator {
        flickableItem: listView
    }

    tools: ToolBarLayout {
        id: toolBarLayout

        ToolIcon {
            iconId: "toolbar-back"
            enabled: false
            opacity: 0.3
        }
        ToolIcon {
            iconSource: "qrc:///settings-icon.png"
            onClicked: window.pageStack.push("qrc:///SettingsPage.qml");
        }
        ToolIcon {
            iconSource: "qrc:///info-icon.png"
            onClicked: window.pageStack.push("qrc:///AboutPage.qml");
        }
    }


    onTestModeEnabledChanged: {
        console.log("Test mode changed to: " + testModeEnabled);
    }
}
