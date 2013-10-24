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
import "UIConstants.js" as UIConstants

Item {
    property bool busy

    width: parent.width
    height: window.noBranding ?
                listHeading.height + currentConditionsDelegate.height :
                titleLabel.height + currentConditionsDelegate.height;

    // Branded header
    HeaderLabel {
        id: titleLabel
        width: parent.width
        anchors.top: parent.top
        busyIndicator: busy
        title: cityName
        iconSource: "qrc:///weatherforecast-icon.png"
        visible: !window.noBranding
    }

    // Basic header
    ListHeading {
        id: listHeading
        anchors.top: parent.top
        visible: window.noBranding

        ListItemText {
            anchors.fill: listHeading.paddingItem
            role: "Heading"
            text: cityName
        }
    }

    ForecastDelegate {
        id: currentConditionsDelegate

        width: parent.width
        height: window.inPortrait ?
                    UIConstants.CURRENT_CONDITIONS_DELEGATE_HEIGHT_PORTRAIT
                  : UIConstants.CURRENT_CONDITIONS_DELEGATE_HEIGHT_LANDSCAPE;
        anchors.top: titleLabel.visible ? titleLabel.bottom : listHeading.bottom
        visible: !busy
        currentConditions: true
        inPortrait: window.inPortrait
        fontSizeLarge: platformStyle.fontSizeLarge
        fontSizeSmall: platformStyle.fontSizeSmall
        textColor: platformStyle.colorNormalLight
        borderColor: currentConditionsDelegate.platformInverted ?
                         platformStyle.colorDisabledLightInverted :
                         platformStyle.colorDisabledMid;
    }

    onBusyChanged: {
        if (!busy) {
            currentConditionsDelegate.weatherCode = getCurrentCondValue("weatherCode");
            currentConditionsDelegate.minTemp = getCurrentCondValue("temp");
            currentConditionsDelegate.windSpeed = getCurrentCondValue("windSpeed");
            currentConditionsDelegate.precip = getCurrentCondValue("precip");
            currentConditionsDelegate.humidity = getCurrentCondValue("humidity");
            currentConditionsDelegate.pressure = getCurrentCondValue("pressure");
            currentConditionsDelegate.cloudCover = getCurrentCondValue("cloudCover");
        }
    }
}

