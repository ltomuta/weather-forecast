/**
 * Copyright (c) 2011-2014 Microsoft Mobile and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#include "wwosupport.h"

#include <QDebug>
#include <QDomComment>
#include <QFile>
#include <QStringList>

/*!
  \class WWOSupport
  \brief Suport class for World Weather Online weather service.
*/


/*!
  Constructor
*/
WWOSupport::WWOSupport(QObject *parent) :
    QObject(parent)
{
    QDomDocument doc("mydocument");
    QFile file(":/wwoConditionCodes.xml");

    if (!file.open(QIODevice::ReadOnly))
        return;

    if (!doc.setContent(&file)) {
        file.close();
        return;
    }

    file.close();

    QDomElement docElem = doc.documentElement();

    QDomNodeList nodeList = docElem.elementsByTagName("condition");

    // Parses xml file content and inserts weather codes with associated tags
    // to the map
    for (int i = 0; i< nodeList.count(); i++) {
        int code = nodeList.at(i).firstChildElement("code").text().toInt();

        QString descTag =
                nodeList.at(i).firstChildElement("day_icon").text().simplified();

        QString descTagParsed =
                descTag.right(descTag.count()
                              - descTag.indexOf('_', descTag.indexOf('_') + 1)
                              - 1);

        mCodesMap.insert(code, descTagParsed);
    }
}

/*!
  Gets a weather tag basing on weather \a code.
*/
QString WWOSupport::descTagForCode(int code)
{
    return mCodesMap.value(code);
}
