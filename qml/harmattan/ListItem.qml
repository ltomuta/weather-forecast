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

Rectangle {
    id: listItem

    signal clicked;

    property alias text: listItemText.text

    height: 80
    color: listItemMouseArea.pressed ? "steelblue" : "#00000000";

    Text {
        id: listItemText

        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: Constants.SMALL_MARGIN
        }

        verticalAlignment: Text.AlignVCenter
        color: platformLabelStyle.textColor

        font {
            family: platformLabelStyle.fontFamily
            pixelSize: platformLabelStyle.fontPixelSize + 5
        }
    }

    Image {
        id: subIndicatorArrow
        width: sourceSize.width

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Constants.SMALL_MARGIN
        }

        smooth: true
        source: "image://theme/icon-m-common-drilldown-arrow"
                + (theme.inverted ? "-inverse" : "");
    }

    MouseArea {
        id: listItemMouseArea
        anchors.fill: parent
        onClicked: listItem.clicked();
    }
}
