/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: window

    property bool testMode: false
    property Style platformLabelStyle: LabelStyle {}

    initialPage: MainPage { testModeEnabled: testMode }
    showStatusBar: true
    showToolBar: true

    Component.onCompleted: {
        // Use the dark theme
        theme.inverted = true;
    }
}
