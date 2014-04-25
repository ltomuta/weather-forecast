/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.0
import com.nokia.symbian 1.1

// Import In-App Analytics QML-plugin
import Analytics 1.0

Page {
    id: settingsPage

    property string initialLanguage: appSettings.availableLanguages()[appSettings.indexOfCurrentLanguage()]

    /*!
      Saves the settings and pops settings page off the stack.
    */
    function saveSettingsAndPopPage()
    {
        appSettings.setCurrentLanguageByIndex(selectionDialog.selectedIndex);
        appSettings.enableAnalytics(iaaSwitch.checked);
        var lang = appSettings.availableLanguages()[selectionDialog.selectedIndex];

        if (window.analytics.loggingEnabled) {
            console.log("In-App Analytics: Save selected language: " + lang);
        }

        window.analytics.start("SettingsPage");
        window.analytics.logEvent("SettingsPage", "Selected language: " + lang,
                                  Analytics.ActivityLogEvent);
        window.analytics.stop("SettingsPage", Analytics.EndSession);
        pageStack.pop();
    }

    /*!
      Disables the IAA.
    */
    function disableIAA()
    {
        iaaSwitch.checked = false;
    }

    Background {
        visible: !window.noBranding
    }

    // Language selection control
    SelectionListItem {
        id: languageSelection

        title: qsTr("Language");
        subTitle: selectionDialog.selectedIndex >= 0
                  ? appSettings.availableLanguages()[selectionDialog.selectedIndex]
                  : qsTr("Please select");

        onClicked: selectionDialog.open();

        // Language selection dialog
        SelectionDialog {
            id: selectionDialog

            titleText: qsTr("Select language");
            selectedIndex: appSettings.indexOfCurrentLanguage();
            model: appSettings.availableLanguages();

            onSelectedIndexChanged: {
                if (initialLanguage != appSettings.availableLanguages()[selectionDialog.selectedIndex])
                    saveButton.enabled = true;
            }
        }
    }


    // In-App Analytics setting switch for on/off
    Row {
        id: iaaSettingRow

        anchors {
            top: languageSelection.bottom
            left: parent.left
            right: parent.right
            topMargin: 20
            leftMargin: 10
            rightMargin: 10
        }

        spacing: 10

        // If IAA enabled, let user change settings
        opacity: window.iaa

        Label {
            width: parent.width - parent.spacing - iaaSwitch.width
            height: iaaSwitch.height
            verticalAlignment: Text.AlignVCenter
            text: qsTr("In-App Analytics");
        }
        Switch {
            id: iaaSwitch
            property bool wasChanged: false
            checked: appSettings.analyticsEnabled === 2 ? true : false;

            onCheckedChanged: {
                if (checked) {
                    console.log("In-App Analytics on");
                }
                else {
                    console.log("In-App Analytics off");
                }
            }
            onClicked: {
                if (checked) {
                    wasChanged = true;
                }

                saveButton.enabled = true;
            }
        }
    }

    tools: ToolBarLayout {
        ToolButton {
            id: saveButton
            text: qsTr("Save")
            enabled: false

            onClicked: {
                if (iaaSwitch.wasChanged && iaaSwitch.checked) {
                    var termsPage = pageStack.push("qrc:/IAATermsPage.qml");
                    termsPage.accepted.connect(saveSettingsAndPopPage);
                    termsPage.rejected.connect(disableIAA);
                }
                else {
                    saveSettingsAndPopPage();
                }
            }
        }
        ToolButton {
            text: qsTr("Cancel")
            onClicked: window.pageStack.pop();
        }
    }
}
