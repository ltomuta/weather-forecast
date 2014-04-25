/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constants.js" as Constants

Page {
    id: termsPage

    signal accepted()
    signal rejected()

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: textLabel.height

        Label {
            id: textLabel

            anchors {
                top: parent.top
                left: parent.left
                topMargin: 10
                leftMargin: 10
            }

            wrapMode: Text.WordWrap
            width: parent.width - 20
            text: Constants.IAATermsEnglish
            onLinkActivated: Qt.openUrlExternally(link);
        }
    }
    ScrollDecorator {
        flickableItem: flickable
    }

    tools: ToolBarLayout {
        ToolButton {
            text: qsTr("Accept");

            onClicked: {
                appSettings.enableAnalytics(true);
                termsPage.accepted();
                pageStack.pop();
            }
        }
        ToolButton {
            text: qsTr("Reject");

            onClicked: {
                appSettings.enableAnalytics(false);
                termsPage.rejected();
                pageStack.pop();
            }
        }
    }
}
