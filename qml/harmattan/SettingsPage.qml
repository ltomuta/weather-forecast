/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: settingsPage

    property string initialLanguage: appSettings.availableLanguages()[appSettings.indexOfCurrentLanguage()]

    Background { }

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

            // TODO: The following list should be replaced with a custom list
            // model. Unfortunately Harmattan does not support usage of
            // QStringList in this case (see the Symbian version of this page).
            model: ListModel {
                ListElement { name: "English" }
                ListElement { name: "Finnish" }
                ListElement { name: "German" }
                ListElement { name: "Polish" }
            }

            onSelectedIndexChanged: {
                console.log(selectionDialog.selectedIndex);

                if (initialLanguage != appSettings.availableLanguages()[selectionDialog.selectedIndex])
                    saveButton.enabled = true;
            }
        }
    }

    tools: ToolBarLayout {
        id: settingsToolBar

        Item {}

        ToolButton {
            id: saveButton
            text: qsTr("Save")
            enabled: false

            onClicked: {
                appSettings.setCurrentLanguageByIndex(selectionDialog.selectedIndex);
                window.pageStack.pop();
            }
        }

        ToolButton {
            text: qsTr("Cancel")

            onClicked: {
                window.pageStack.pop();
            }
        }

        Item {}
    }
}
