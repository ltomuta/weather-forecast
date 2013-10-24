/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#ifndef ANALYTICSSTUB_H
#define ANALYTICSSTUB_H

#include <QObject>

class Analytics : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int connectionTypePreference READ connectionTypePreference WRITE setConnectionTypePreference)
    Q_PROPERTY(bool loggingEnabled READ loggingEnabled WRITE setLoggingEnabled)
    Q_PROPERTY(int minBundleSize READ minBundleSize WRITE setMinBundleSize)
    Q_ENUMS(AnalyticsEnums)

public:
    enum AnalyticsEnums {
        AnyConnection
    };

public:
    explicit Analytics(QObject *parent = 0) : QObject(parent) {}

public:
    int connectionTypePreference() const { return 0; }
    void setConnectionTypePreference(int) {}
    bool loggingEnabled() const { return mLoggingEnabled; }
    void setLoggingEnabled(bool enabled) { mLoggingEnabled = enabled; }
    int minBundleSize() const { return 0; }
    void setMinBundleSize(int) {}

public slots:
    void initialize(QString, QString) {}
    void start(QString) {}
    void stop(QString, int) {}
    void logEvent(QString, QString, int) {}

private: // Data
    bool mLoggingEnabled;
};


#endif // ANALYTICSSTUB_H
