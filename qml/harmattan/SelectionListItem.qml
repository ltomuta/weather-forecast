/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import "Constants.js" as Constants
import "UIConstants.js" as UIConstants

Item {
    id: root

    property string title: ""
    property string subTitle: ""
    property int titleTextSize: 24
    property int subTitleTextSize: 24
    property Item paddingItem: realPaddingItem

    signal clicked

    // Private properties
    property int __defaultMargin: Constants.SMALL_MARGIN
    property int __rounding: UIConstants.DEFAULT_BUTTON_RADIUS

    width: parent.width
    height: contentsRow.height + 4 * root.__defaultMargin

    Item {
        id: realPaddingItem
        x: 2 * root.__defaultMargin
        y: 2 * root.__defaultMargin
        height: contentsRow.height
        width: contentsRow.width
    }

    Gradient {
        id: defaultGradient
        GradientStop { position: 0.0; color: "#444444" }
        GradientStop { position: 1.0; color: "#111111" }
    }

    Gradient {
        id: pressedGradient
        GradientStop { position: 0.0; color: "#1080DD" }
        GradientStop { position: 1.0; color: "#53A4E7" }
    }

    Rectangle {
        id: background
        x: root.__defaultMargin
        y: root.__defaultMargin
        width: parent.width - 2 * root.__defaultMargin
        height: parent.height - 2 * root.__defaultMargin
        gradient: listItemMouseArea.pressed ? pressedGradient : defaultGradient
        radius: root.__rounding
        smooth: true

        Row {
            id: contentsRow
            x: root.__defaultMargin
            y: root.__defaultMargin
            height: titleText.height * 2 + root.__defaultMargin
            width: parent.width
            spacing: root.__defaultMargin

            Column {
                spacing: root.__defaultMargin
                width: parent.width

                Text {
                    id: titleText
                    text: root.title
                    color: "white"
                    font.pixelSize: root.titleTextSize
                    font.bold: true
                }
                Text {
                    text: root.subTitle
                    wrapMode: Text.NoWrap
                    font.pixelSize: root.subTitleTextSize
                    color: "gray"
                }
            }
        }

        MouseArea {
            id: listItemMouseArea
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
