/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include "appsettings.h"

#include <QDebug>
#include <QLocale>
#include <QSettings>

#include "translate.h"


/*!
  \class AppSettings
  \brief Applciation settings class.
*/


/*!
  Constructor
*/
AppSettings::AppSettings(QObject *parent) :
    QObject(parent)
{
    // Application settings
    mSettings = new QSettings("settings.ini", QSettings::IniFormat, this);

    mTranslate = new Translate();

    // Reading settings
    setCurrentLanguageByIndex(mSettings->value("currentLanguage").toInt());
    mAnalyticsEnabled = mSettings->value("analyticsEnabled", 0).toInt();
}

/*!
  Destructor
*/
AppSettings::~AppSettings()
{
    delete mTranslate;
}

/*!
  Returns list of available languages.
*/
QStringList AppSettings::availableLanguages()
{
    return mTranslate->availableLanguages();
}

/*!
  Sets current languaguage basing on \a index of the language in languages
  list.
*/
void AppSettings::setCurrentLanguageByIndex(int index)
{
    if (index < mTranslate->availableLanguages().count()) {
        QString language = mTranslate->availableLanguages()[index];
        int languageIndexBeforeTranslation = availableLanguages().indexOf(language);

        mSettings->setValue("currentLanguage", index);

        mTranslate->loadTranslate(index);

        // save the language to the value after translation basing on the
        // index taken before translation
        mCurrentLanguage = availableLanguages()[languageIndexBeforeTranslation];

        // emit signal to cause qml strings to be updated after translation
        // it's workaround for a bug causing that qml files ignore language
        // changed event
        emit languageChanged(QString());
    }
}

/*!
  Returns the current language as string.
*/
QString AppSettings::currentLanguage() const
{
    return mCurrentLanguage;
}

/*!
  Returns index of current language in languages list.
*/

int AppSettings::indexOfCurrentLanguage()
{
    return availableLanguages().indexOf(mCurrentLanguage);
}

/*!
 Is In-App Analytics enabled
 0 = Need to ask permission to enable In-App Analytics from the user
 1 = User did not let enable In-App Analytics
 2 = User allowed to enable In-App Analytics
*/
int AppSettings::analyticsEnabled()
{
    return mAnalyticsEnabled;
}

/*!
 Enable or disable usage of In-App Analytics in this application
 0 = Need to ask permission to enable In-App Analytics from the user
 1 = User did not let enable In-App Analytics
 2 = User allowed to enable In-App Analytics
*/
void AppSettings::enableAnalytics(bool enable)
{
    if (enable) {
        mAnalyticsEnabled = 2;
    } else {
        mAnalyticsEnabled = 1;
    }
    mSettings->setValue("analyticsEnabled", mAnalyticsEnabled);

    emit analyticsChanged(mAnalyticsEnabled);
}
