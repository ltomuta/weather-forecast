/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1

Rectangle {
    id: splashScreen

    property string gradientColor: imagesPathView.model.get(syncIndex(0)).shade

    /**
     * Syncs shade with the given index.
     */
    function syncIndex(index)
    {
        var shadeIndex = imagesPathView.currentIndex + 2;


        if (shadeIndex >= imagesPathView.model.count) {
            shadeIndex -= imagesPathView.model.count;
        }

        return shadeIndex;
    }

    gradient: Gradient {
        GradientStop { position: 0; color: "black" }
        GradientStop { position: 0.3; color: "black" }
        GradientStop {
            position: 1
            color: splashScreen.gradientColor

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }

    Image {
        id: titleLogo

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: parent.height / 4
            leftMargin: 20
            rightMargin: anchors.leftMargin
        }

        z: 1
        smooth: true
        fillMode: Image.PreserveAspectFit
        source: "qrc:///title-logo.png"
    }

    // Uncomment this if you want the localized string in the splash screen
    /*Text {
        id: titleText

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height / 4
        }

        z: 1
        color: "white"
        font.pixelSize: parent.height > parent.width ?
                            parent.width / 8 : parent.height / 8;
        text: qsTr("Weather forecast");
    }*/

    Text {
        width: titleLogo.width

        anchors {
            top: titleLogo.bottom //titleText.bottom
            right: titleLogo.right //titleText.right
        }

        z: 1
        color: "gray"
        horizontalAlignment: Text.AlignRight
        font.pixelSize: parent.height > parent.width ?
                            parent.width / 16 : parent.height / 16;
        text: qsTr("Version") + " " + appVersion;
    }

    ListModel {
        id: imagesModel
        ListElement { icon: "qrc:///sunny.png"; shade: "#ffff00" }
        ListElement { icon: "qrc:///cloudy_with_heavy_rain.png"; shade: "#2222aa" }
        ListElement { icon: "qrc:///cloudy_with_heavy_snow.png"; shade: "#cccccc" }
        ListElement { icon: "qrc:///white_cloud.png"; shade: "#3333cc" }
    }

    PathView  {
        id: imagesPathView

        width: parent.height > parent.width ?
                   parent.width / 3 : parent.height / 3;
        height: width * 0.75

        anchors {
            top: parent.top
            left: parent.left
            topMargin: parent.height / 2
            leftMargin: parent.width / 2
        }

        model: imagesModel

        delegate: Image {
            id: delegate
            property string _color: color
            opacity: PathView.iconOpacity
            scale: PathView.iconScale
            smooth: true
            source: icon
        }

        path: Path  {
            startX: 0
            startY: -imagesPathView.height

            PathAttribute { name: "iconOpacity"; value: 0.1 }
            PathAttribute { name: "iconScale"; value: 0.1 }
            PathQuad {
                x: 0
                y: imagesPathView.height
                controlX: imagesPathView.width
                controlY: 0
            }
            PathAttribute { name: "iconOpacity"; value: 1.0 }
            PathAttribute { name: "iconScale"; value: 2.0 }
            PathQuad {
                x: 0
                y: -imagesPathView.height
                controlX: -imagesPathView.width
                controlY: 0
            }
        }

        onCurrentIndexChanged: {
            // Change the gradient color according to the current item
            splashScreen.gradientColor =
                    imagesPathView.model.get(syncIndex(currentIndex)).shade;
        }
    }

    Timer {
        id: indexChanger
        running: true
        repeat: true
        interval: 750

        onTriggered: {
            // Change the index
            if (imagesPathView.currentIndex >= imagesPathView.model.count) {
                imagesPathView.currentIndex = 0;
            }
            else {
                imagesPathView.currentIndex += 1;
            }
        }
    }

    Component.onCompleted: {
        // Select a random index so that the animation differs from time to time
        var randomIndex = Math.random() * (imagesPathView.model.count - 1);
        randomIndex = Math.round(randomIndex);
        imagesPathView.currentIndex = randomIndex;
    }
}
