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
    id: aboutPage

    Background { }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: headerLabel.height
                       + appNameAndVersionText.height
                       + infoText.height
                       + wwoCreditRow.height
                       + Constants.DEFAULT_MARGIN * 4

        HeaderLabel {
            id: headerLabel

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            title: qsTr("About");
            iconSource: "qrc:///weatherforecast-icon.png"
        }

        Text {
            id: appNameAndVersionText

            height: font.pixelSize + Constants.DEFAULT_MARGIN

            anchors {
                top: headerLabel.bottom
                left: parent.left
                right: parent.right
                topMargin: Constants.SMALL_MARGIN
                leftMargin: Constants.SMALL_MARGIN
            }

            color: platformLabelStyle.textColor

            font {
                family: platformLabelStyle.fontFamily
                pixelSize: platformLabelStyle.fontPixelSize
                bold: true
            }

            text: qsTr("Weather forecast") + " " + appVersion;
        }

        Text {
            id: infoText

            anchors {
                top: appNameAndVersionText.bottom
                left: parent.left
                right: parent.right
                margins: Constants.SMALL_MARGIN
            }

            color: platformLabelStyle.textColor

            font {
                family: platformLabelStyle.fontFamily
                pixelSize: platformLabelStyle.fontPixelSize
            }

            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            onLinkActivated: Qt.openUrlExternally(link);

            text: {
                if (appSettings.currentLanguage == qsTr("Finnish")) {
                    return Constants.infoTextFinnish;
                }

                if (appSettings.currentLanguage == qsTr("German")) {
                    return Constants.infoTextGerman;
                }

                if (appSettings.currentLanguage == qsTr("Polish")) {
                    return Constants.infoTextPolish;
                }

                return Constants.infoTextEnglish;
            }
        }

        Row {
            id: wwoCreditRow
            height: wwoIcon.height

            anchors {
                top: infoText.bottom
                left: parent.left
                right: parent.right
                topMargin: Constants.DEFAULT_MARGIN * 2
                margins: Constants.SMALL_MARGIN
            }

            spacing: Constants.SMALL_MARGIN

            Image {
                id: wwoIcon
                width: window.inPortrait ? parent.width / 2 : parent.width / 4
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "qrc:///wwo-logo.png"
            }

            Text {
                id: wwoCreditText

                width: parent.width - wwoIcon.width - Constants.SMALL_MARGIN
                height: parent.height
                color: platformLabelStyle.textColor

                font {
                    family: platformLabelStyle.fontFamily
                    pixelSize: platformLabelStyle.fontPixelSize - 2
                }

                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link);

                text: "<p>Powered by <a href=\"http://www.worldweatheronline.com/\""
                    + " title=\"Free local weather content provider\" target=\"_blank\">"
                    + "World Weather Online</a></p>";
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }

    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-back"
            onClicked: window.pageStack.pop()
        }
    }
}
