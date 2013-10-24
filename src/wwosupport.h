/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef WWOSUPPORT_H
#define WWOSUPPORT_H

#include <QMap>
#include <QObject>

class WWOSupport : public QObject
{
    Q_OBJECT

public:
    explicit WWOSupport(QObject *parent = 0);

public:
    Q_INVOKABLE QString descTagForCode(int code);

private:
    QMap<int, QString> mCodesMap;

};

#endif // WWOSUPPORT_H
