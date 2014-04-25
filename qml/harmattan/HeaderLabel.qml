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

Item {
     id: headerLabel
     width: parent ? parent.width : 480;
     height: window.inPortrait ?
                 UIConstants.TITLE_LABEL_HEIGHT_PORTRAIT :
                 UIConstants.TITLE_LABEL_HEIGHT_LANDSCAPE;

     property string title;
     property bool showBusyIndicator: false
     property string accentColor: "#333333" // Default background color
     property alias iconSource: icon.source
     property alias imageSource: headerImage.source

     Image {
         id: icon
         width: sourceSize.width

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
             left: icon.right
             right: parent.right
             verticalCenter: parent.verticalCenter
             leftMargin: Constants.SMALL_MARGIN
             rightMargin: Constants.SMALL_MARGIN
         }

         visible: !imageSource.length
         color: platformLabelStyle.textColor
         elide: Text.ElideRight

         font {
             family: platformLabelStyle.fontFamily
             pixelSize: UIConstants.TITLE_FONT_SIZE
         }

         // Adding appSettings.emptyString to text is a workaround for a Qt bug
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
             margins: Constants.SMALL_MARGIN
         }

         smooth: true
         fillMode: Image.PreserveAspectFit
     }

     BusyIndicator {
         anchors {
             right: parent.right
             verticalCenter: parent.verticalCenter
             rightMargin: Constants.SMALL_MARGIN
         }

         running: showBusyIndicator
         opacity: running ? 1 : 0

         Behavior on opacity { NumberAnimation { duration: 200 } }
     }

     // Separator
     Rectangle {
         width: parent.width
         height: 1
         anchors.bottom: parent.bottom
         color: headerLabel.accentColor
     }
 }
