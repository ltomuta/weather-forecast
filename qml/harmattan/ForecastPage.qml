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
import "UIConstants.js" as UIConstants
import "HttpRequest.js" as HttpRequest

Page {
    id: forecastPage

    property bool testMode
    property string xmlData;
    property string cityName;
    property bool pageBusy: true;
    property variant currentCondAttributes: null;

    /**
     * Gets one of the values from currentCondAttributes variant
     */
    function getCurrentCondValue(value)
    {
        if (currentCondAttributes == null)
            return "";

        return currentCondAttributes[value];
    }

    Background { }

    ListView {
        id: listView

        anchors.fill: parent
        model: xmlModel

        header: ForecastHeader {
            busy: pageBusy
        }

        delegate: ForecastDelegate {
            width: forecastPage.width
            height: window.inPortrait ?
                        UIConstants.FORECAST_DELEGATE_HEIGHT_PORTRAIT
                      : UIConstants.FORECAST_DELEGATE_HEIGHT_LANDSCAPE;

            date: model.date
            maxTemp: model.tempMax
            minTemp: model.tempMin
            windSpeed: model.windspeed
            precip: model.precip
            fontSizeLarge: platformLabelStyle.fontPixelSize + 2
            fontSizeSmall: platformLabelStyle.fontPixelSize - 2
            textColor: platformLabelStyle.textColor
            weatherCode: model.weatherCode
            inPortrait: window.inPortrait
        }
    } // ListView

    ScrollDecorator {
        flickableItem: listView
    }

    XmlListModel {
        id: xmlModel
        xml: xmlData
        query: "/data/weather"

        XmlRole { name: "date"; query: "date/string()" }
        XmlRole { name: "weatherCode"; query: "weatherCode/string()" }
        XmlRole { name: "tempMax"; query: "tempMaxC/string()" }
        XmlRole { name: "tempMin"; query: "tempMinC/string()" }
        XmlRole { name: "windspeed"; query: "windspeedKmph/string()" }
        XmlRole { name: "precip"; query: "precipMM/string()" }
    }

    // Network error dialog
    Dialog {
        id: networkErrorDialog

        title: Text {
            height: 100

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: Constants.DEFAULT_MARGIN
            }

            color: platformLabelStyle.textColor

            font {
                family: platformLabelStyle.fontFamily
                pixelSize: platformLabelStyle.fontPixelSize + 2
            }

            text: qsTr("Network error occured") + appSettings.emptyString
        }

        buttons: Item {
            Button {
                text: qsTr("Ok") + appSettings.emptyString

                onClicked: {
                    networkErrorDialog.close();
                    HttpRequest.req.abort();
                    window.pageStack.push(Qt.resolvedUrl("MainPage.qml"));
                }
            }
        }
    } // Dialog

    // Network timeout timer
    Timer {
        id: timer
        interval: Constants.NETWORK_TIMEOUT
        repeat: false
        onTriggered: HttpRequest.req.abort();
    }

    onStatusChanged: {
        if (status == PageStatus.Active) {
            HttpRequest.sendHttpRequest(cityName);
            timer.start();
        }
    }

    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-back"
            onClicked: window.pageStack.pop()
        }
    }
}
