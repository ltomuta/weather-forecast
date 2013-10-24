/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import "Constants.js" as Constants

Rectangle {
    anchors.fill: parent
    gradient: Gradient {
        GradientStop { position: 0; color: "black" }
        GradientStop { position: 0.3; color: "black" }
        GradientStop { position: 1; color: Constants.BACKGROUND_GRADIENT }
    }
}
