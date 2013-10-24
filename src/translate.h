/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef TRANSLATE_H
#define TRANSLATE_H

#include <QStringList>

class QStringList;
class QTranslator;

class Translate
{
public:
    explicit Translate();
    ~Translate();

public:
    void loadLanguagesStrings();
    QStringList availableLanguages();
    void loadTranslate(int index);

private:
    QTranslator *mTranslator; // Owned
    QStringList mAvailableLanguages;
};

#endif // TRANSLATE_H
