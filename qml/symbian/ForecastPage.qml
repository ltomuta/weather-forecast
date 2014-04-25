/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constants.js" as Constants
import "UIConstants.js" as UIConstants
import "HttpRequest.js" as HttpRequest

Page {
    id: forecastPage

    property bool testMode
    property string xmlData
    property string cityName
    property bool pageBusy: true
    property variant currentCondAttributes: null

    /**
     * Gets one of the values from currentCondAttributes variant
     */
    function getCurrentCondValue(value)
    {
        if (currentCondAttributes == null)
            return "";

        return currentCondAttributes[value];
    }

    Background {
        visible: !window.noBranding
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: xmlModel

        header: ForecastHeader {
            width: forecastPage.width
            busy: pageBusy
        }

        delegate: ForecastDelegate {
            id: delegate
            width: forecastPage.width
            height: window.inPortrait ?
                        UIConstants.FORECAST_DELEGATE_HEIGHT_PORTRAIT
                      : UIConstants.FORECAST_DELEGATE_HEIGHT_LANDSCAPE;

            date: model.date
            maxTemp: model.tempMax
            minTemp: model.tempMin
            windSpeed: model.windspeed
            precip: model.precip
            fontSizeLarge: platformStyle.fontSizeLarge
            fontSizeSmall: platformStyle.fontSizeSmall
            textColor: platformStyle.colorNormalLight
            borderColor: delegate.platformInverted ? platformStyle.colorDisabledLightInverted
                                                   : platformStyle.colorDisabledMid;
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
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            font.pointSize: 8
            color: platformStyle.colorNormalLight
            text: qsTr("Network error occured") + appSettings.emptyString
        }

        buttons: Item {
            width: parent.width
            height: childrenRect.height + Constants.DEFAULT_MARGIN

            Button {
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Ok") + appSettings.emptyString

                onClicked: {
                    networkErrorDialog.close();
                    HttpRequest.dismissRequest();
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
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: {
                window.pageStack.pop();
                HttpRequest.dismissRequest();
            }
        }
    }
}
