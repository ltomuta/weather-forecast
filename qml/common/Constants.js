/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

// The API key for World Weather Online API
var API_KEY = "1242585fad170731112411"

var months = [qsTr("January"), qsTr("February"), qsTr("March"), qsTr("April"), qsTr("May"), qsTr("June"),
              qsTr("July"), qsTr("August"), qsTr("September") ,qsTr("October"), qsTr("November"), qsTr("December")];

var DEFAULT_MARGIN = 20;
var SMALL_MARGIN = 10;
var DEFAULT_FONT_SIZE_LARGE = 24;
var DEFAULT_FONT_SIZE_SMALL = 18;
var MAIN_PAGE_DELEGATE_HEIGHT = 80;
var VALUE_DESC_TEXT_COLOR = "lightblue";
var BACKGROUND_GRADIENT = "#343887";
var NETWORK_TIMEOUT = 10000;


var infoTextEnglish =
        "<p>This is a Nokia Developer example application ported from "
        + "Windows Phone to Qt. This simple Qt Quick application parses "
        + "weather forecast content from XML data retrieved over the "
        + "network.</p>"
        + "<p>In addition, the example demonstrates how to implement "
        + "internationalization with Qt and Qt Quick. The application supports "
        + "four languages: English, Finnish, German and Polish.</p>"
        + "<p>Visit "
        + "<a href=\"http://projects.developer.nokia.com/weatherforecast/\">"
        + "projects.developer.nokia.com</a> to learn more "
        + "about this example.</p>";

var infoTextFinnish =
        "<p>Tämä on Nokia Developer -esimerkkisovellus, joka on siirretty "
        + "Windows Phone -alustalta Qt-sovelluskehitysympäristöön. Tämä "
        + "yksinkertainen Qt Quick -sovellus jäsentää sääennusteita verkosta "
        + "haetusta XML-muotoisesta tiedosta.</p>"
        + "<p>Lisäksi esimerkkisovellus näyttää, kuinka sovellus voidaan "
        + "kansainvälistää Qt:n ja Qt Quickin avulla. Sovellus tukee neljää "
        + "kieltä: englantia, suomea, saksaa ja puolaa.</p>"
        + "<p>Lisätietoa esimerkkisovelluksesta saat täältä "
        + "<a href=\"http://projects.developer.nokia.com/weatherforecast/\">"
        + "projects.developer.nokia.com</a></p>";

var infoTextGerman =
        "<p>Dieses ist eine Nokia Developer Beispielanwendung. Sie wurde von "
        + "Windows Phone nach Qt portiert. Diese einfache Qt Quick Anwendung "
        + "parst Wettervorhersageinformation aus XML-Daten, welche aus dem "
        + "Netzwerk abgerufen werden.</p>"
        + "<p>Zusätzlich zeigt dieses Beispiel wie eine mehrsprachige "
        + "Anwendung mit Qt und Qt Quick erstellt wird. In diesem Programm "
        + "werden vier Sprachen unterstützt: Englisch, Finnisch, Deutsch und "
        + "Polnisch.</p>"
        + "<p>Weitere Informationen zu dieser Beispielanwendung gibt es unter "
        + "<a href=\"http://projects.developer.nokia.com/weatherforecast/\">"
        + "projects.developer.nokia.com</a></p>";

var infoTextPolish =
        "<p>Ta demonstracyjna aplikacja została zportowana z "
        + "Windows Phone na Qt w ramach programu Nokia Developer. "
        + "Aplikacja wykorzystuje dane pogodowe w formacie XML "
        + "pobrane z serwisu web.</p>"
        + "<p>Dodatkowo aplikacja demonstruje implementacje obsługi wielu "
        + "języków. Wspierane są cztery języki: Angielski, Fiński, Niemiecki "
        + "oraz Polski. "
        + "Odwiedź "
        + "<a href=\"http://projects.developer.nokia.com/weatherforecast/\">"
        + "projects.developer.nokia.com</a> aby dowiedzieć się więcej o tej aplikacji.";

var IAATermsEnglish = "<p>"
        +"To enable future improvements, application usage data is being collected by this Nokia example application. You can switch the analytics data collection on/off from the settings at any time."
        +"</p>"
        +"<p>"
        +"The information is collected in accordance with <a href=\"http://www.nokia.com/global/privacy/privacy/policy/privacy-policy\">Nokia Privacy Policy.</a>"
        +"</p>";
