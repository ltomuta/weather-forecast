/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import "Constants.js" as Constants
import "UIConstants.js" as UIConstants

Item {
    id: delegate

    // This property is set true for the top-most delegate that contains the
    // weather values for the current conditions
    property bool currentConditions: false

    property bool inPortrait

    property string date
    property int weatherCode
    property real minTemp // This is the temp to set for the current conditions
    property real maxTemp
    property real windSpeed
    property real precip

    // Values for current conditions only
    property real humidity
    property real pressure
    property real cloudCover

    property int fontSizeLarge: Constants.DEFAULT_FONT_SIZE_LARGE
    property int fontSizeSmall: Constants.DEFAULT_FONT_SIZE_SMALL
    property string textColor: "white" // Default text color
    property string borderColor: "#555555" // Default border color

    onWeatherCodeChanged: {
        forecastImage.source = wwoSupport.descTagForCode(weatherCode) + ".png";
    }

    /**
     * Formats the date.
     */
    function formatDate(date)
    {
        var dateValues = date.split("-");

        if (dateValues.count < 2) {
            return;
        }

        var month = dateValues[1];
        var day = dateValues[2];

        if (appSettings.currentLanguage == qsTr("English")) {
            var suffix = "th";

            if (day == 1) {
                suffix = "st";
            }
            else if (day == 2) {
                suffix = "nd";
            }
            else if (day == 3) {
                suffix = "rd";
            }

            return Constants.months[month - 1] + " " + day + suffix;
        }

        if (appSettings.currentLanguage == qsTr("Finnish")) {
            return day + ". " + Constants.months[month - 1] + "ta";
        }

        //if (appSettings.currentLanguage == qsTr("German")) {
            return day + ". " + Constants.months[month - 1];
        //}
    }

    Item {
        id: container

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: Constants.SMALL_MARGIN
            rightMargin: Constants.SMALL_MARGIN
        }

        // Date
        Text {
            id: dateText

            anchors {
                top: parent.top
                topMargin: Constants.SMALL_MARGIN
            }

            font.pixelSize: delegate.fontSizeLarge
            font.bold: true
            color: delegate.textColor
            text: delegate.currentConditions ?
                      qsTr("Current conditions") : formatDate(date);
        }

        // Forecast image
        Image {
            id: forecastImageBackground
            width: height
            height: UIConstants.WEATHER_IMAGE_HEIGHT

            anchors {
                top: parent.top
                right: parent.right
                topMargin: (parent.height - height) / 2
            }

            smooth: true
            source: "qrc:///weather-icon-bg.png"
        }
        Image {
            id: forecastImage

            anchors {
                fill: forecastImageBackground
                bottomMargin: Constants.SMALL_MARGIN
            }

            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Forecast values
        Grid {
            id: valuesGrid

            anchors {
                top: dateText.bottom
                left: container.left
                right: forecastImageBackground.left
                margins: Constants.SMALL_MARGIN
            }

            columns: delegate.inPortrait ? 1 : 2

            Row {
                id: temperatureRow
                width: valuesGrid.columns == 1 ? parent.width : parent.width / 2
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: delegate.currentConditions ?
                              qsTr("Temp: ") : qsTr("Temp (min - max): ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: delegate.currentConditions ?
                              minTemp + " \u00B0C" : minTemp + " ... " + maxTemp + " \u00B0C";
                }
            }

            // Spacer item to make sure the temperature row has its own column
            // Not used if displaying current conditions
            Item {
                width: temperatureRow.width
                height: temperatureRow.height
                opacity: (delegate.currentConditions || delegate.inPortrait) ? 0 : 1
            }

            Row {
                width: temperatureRow.width
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: qsTr("Wind: ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: windSpeed + " km/h"
                }
            }
            Row {
                width: temperatureRow.width
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: qsTr("Precipitation: ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: precip + " mm"
                }
            }

            // Values shown only when displaying current conditions
            Row {
                width: temperatureRow.width
                visible: currentConditions
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: qsTr("Humidity: ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: humidity + " %"
                }
            }
            Row {
                width: temperatureRow.width
                visible: currentConditions
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: qsTr("Pressure: ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: pressure + " hPa"
                }
            }
            Row {
                width: temperatureRow.width
                visible: currentConditions
                spacing: Constants.SMALL_MARGIN

                Text {
                    color: Constants.VALUE_DESC_TEXT_COLOR
                    font.pixelSize: delegate.fontSizeSmall
                    text: qsTr("Cloud cover: ");
                }
                Text {
                    color: delegate.textColor
                    font.pixelSize: delegate.fontSizeSmall
                    text: cloudCover + " %"
                }
            }
        }
    }

    // Border
    Rectangle {
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
        color: delegate.borderColor
    }
}
