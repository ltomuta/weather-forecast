/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QMap>
#include <QObject>
#include <QStringList>

class QSettings;
class Translate;

class AppSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ emptyString NOTIFY languageChanged)
    Q_PROPERTY(QString currentLanguage READ currentLanguage NOTIFY languageChanged)

    Q_PROPERTY (int analyticsEnabled READ analyticsEnabled NOTIFY analyticsChanged)

public:
    explicit AppSettings(QObject *parent = 0);
    ~AppSettings();

public:
    Q_INVOKABLE QStringList availableLanguages();
    Q_INVOKABLE void setCurrentLanguageByIndex(int index);
    QString currentLanguage() const;
    Q_INVOKABLE int indexOfCurrentLanguage();
    QString emptyString() { return ""; }

    int analyticsEnabled();
    Q_INVOKABLE void enableAnalytics(bool enable);

signals:
    void languageChanged(QString language);
    void analyticsChanged(int);

private:
    QSettings *mSettings; // Owned
    Translate *mTranslate; // Owned
    QString mCurrentLanguage;
    int mAnalyticsEnabled;
};

#endif // APPSETTINGS_H
