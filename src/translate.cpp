/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include "translate.h"

#include <QApplication>
#include <QDebug>
#include <QObject>
#include <QTranslator>

/*!
  \class Translate
  \brief Responsible for loading translate files for application localization.
*/

/*!
  Constructor
*/
Translate::Translate()
{
    loadLanguagesStrings();
}

/*!
  Destructor
*/
Translate::~Translate()
{
    delete mTranslator;
}

/*!
  Loads language strings.
*/
void Translate::loadLanguagesStrings()
{
    mAvailableLanguages = QStringList()
            << QObject::tr("English")
            << QObject::tr("Finnish")
            << QObject::tr("German")
            << QObject::tr("Polish");
}

/*!
  Returns list of available languages.
*/
QStringList Translate::availableLanguages()
{
    return mAvailableLanguages;
}

/*!
  Loads translate proper file basing on \a index of the language in languages list.
*/
void Translate::loadTranslate(int index)
{
    mTranslator = new QTranslator();

    QString languageCode;
    QString language;

    if (index < availableLanguages().count())
        language = availableLanguages()[index];
    else
        return;

    if (language == QObject::tr("Polish"))
        languageCode = "pl";
    else if (language == QObject::tr("German"))
        languageCode = "ge";
    else if (language == QObject::tr("Finnish"))
        languageCode = "fi";
    else
        languageCode = "en";

    mTranslator->load(":/base_" + languageCode);

    QApplication::instance()->installTranslator(mTranslator);

    loadLanguagesStrings();
}
