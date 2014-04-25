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

Item {
    id: listHeader
    height: window.inPortrait ?
                UIConstants.TITLE_LABEL_HEIGHT_PORTRAIT :
                UIConstants.TITLE_LABEL_HEIGHT_LANDSCAPE;

    property string title
    property alias iconSource: icon.source
    property alias imageSource: headerImage.source
    property bool busyIndicator: false

    Image {
        id: icon

        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            margins: Constants.SMALL_MARGIN
        }

        visible: !imageSource.length
        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    Text {
        anchors {
            left: iconSource ? icon.right : parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: Constants.SMALL_MARGIN
            rightMargin: Constants.SMALL_MARGIN
        }

        elide: Text.ElideRight
        font.pointSize: UIConstants.TITLE_FONT_SIZE
        color: platformStyle.colorNormalLight
        visible: !imageSource.length

        // adding appSettings.emptyString to text is a workaround for a Qt bug
        // a signal that emptyString is changed (which actually is still empty)
        // is sent when app language changes and causes that all texts referencin
        // emptyString property are retlanslated.
        text: title + appSettings.emptyString
    }

    Image {
        id: headerImage

        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            margins: window.inPortrait ?
                         Constants.SMALL_MARGIN : Constants.SMALL_MARGIN / 2;
        }

        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    BusyIndicator {
        anchors.right: parent.right
        anchors.rightMargin: Constants.SMALL_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        running: busyIndicator
        visible: busyIndicator
    }

    // Separator
    Rectangle {
        width: parent.width
        height: 1
        z: 1
        anchors.bottom: parent.bottom
        color: platformStyle.colorDisabledMid
    }
}
