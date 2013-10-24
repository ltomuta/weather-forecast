/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import "Constants.js" as Constants
import "UIConstants.js" as UIConstants

Item {
    property bool busy

    width: parent.width
    height: titleLabel.height + currentConditionsDelegate.height

    HeaderLabel {
        id: titleLabel

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        showBusyIndicator: busy
        title: cityName
        iconSource: "qrc:///weatherforecast-icon.png"
    }

    ForecastDelegate {
        id: currentConditionsDelegate

        width: parent.width
        height: window.inPortrait ?
                    UIConstants.CURRENT_CONDITIONS_DELEGATE_HEIGHT_PORTRAIT
                  : UIConstants.CURRENT_CONDITIONS_DELEGATE_HEIGHT_LANDSCAPE;
        anchors.top: titleLabel.bottom

        visible: !busy
        currentConditions: true
        inPortrait: window.inPortrait
        fontSizeSmall: platformLabelStyle.fontPixelSize - 2
        textColor: platformLabelStyle.textColor
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

