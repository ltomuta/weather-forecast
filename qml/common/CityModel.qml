/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

import QtQuick 1.1

// Model for cities
// The weather data is fetched based on the name of the city in
// httpRequest.js file.
// Feel free to add additional cities or remove any of the existing ones.
ListModel {
    id: cityModel

    ListElement { city: "Berlin"; country: "Germany" }
    ListElement { city: "Helsinki"; country: "Finland" }
    ListElement { city: "London"; country: "United Kingdom" }
    ListElement { city: "New York"; country: "United States" }
    ListElement { city: "Oslo"; country: "Norway" }
    ListElement { city: "San Francisco"; country: "United States" }
    ListElement { city: "Tampere"; country: "Finland" }
    ListElement { city: "Warsaw"; country: "Poland" }
}
