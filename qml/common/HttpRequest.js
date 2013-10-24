/**
 * Copyright (c) 2011 Nokia Corporation and/or its subsidiary(-ies).
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

var req;
var reqInProgress = new Boolean(false);

function sendHttpRequest(city)
{
    if (reqInProgress == false) {
        req = new XMLHttpRequest();

        req.onreadystatechange = function() {
            if (req.readyState == XMLHttpRequest.DONE)
            {
                if ((req.status == "200" || (req.status == 0 && testMode))
                        && req.responseXML != null)
                {
                    if (req.responseXML != null) {
                        var root = req.responseXML.documentElement;
                        var observationTime;
                        var temp;
                        var weatherCode;
                        var windSpeed;
                        var precip;
                        var humidity;
                        var pressure;
                        var cloudCover;

                        for (var i = 0; i < root.childNodes.length; ++i) {
                            var curCondNode = root.childNodes[i];

                            if (curCondNode.nodeName == "current_condition") {
                                for (var j = 0; j < curCondNode.childNodes.length; ++j) {
                                    var node = curCondNode.childNodes[j];

                                    if (node.nodeName == "observation_time") {
                                        observationTime = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "temp_C") {
                                        temp = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "weatherCode") {
                                        weatherCode = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "windspeedKmph") {
                                        windSpeed = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "precipMM") {
                                        precip = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "humidity") {
                                        humidity = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "pressure") {
                                        pressure = node.childNodes[0].nodeValue;
                                    }

                                    if (node.nodeName == "cloudcover") {
                                        cloudCover = node.childNodes[0].nodeValue;
                                    }
                                }
                            }
                        }

                        xmlData = req.responseText;

                        currentCondAttributes = {
                            'observationTime': observationTime,
                            'temp': temp,
                            'weatherCode': weatherCode,
                            'windSpeed': windSpeed,
                            'precip': precip,
                            'humidity': humidity,
                            'pressure': pressure,
                            'temp': temp,
                            'cloudCover': cloudCover };

                        pageBusy = false;
                    }
                }
                else {
                    console.log("Unexpected error");

                    if (reqInProgress) {
                        networkErrorDialog.open();
                    }
                }

                reqInProgress = false;
                timer.stop();
            }
        }

        var apiKey = Constants.API_KEY;

        if (apiKey.length != 0 || testMode)
        {
            if (!testMode) {
                var url = "http://free.worldweatheronline.com/feed/weather.ashx?q="
                          + city + "&format=xml&num_of_days=5&key=" + apiKey;
            }
            else {
                url = "testData.xml";
            }

            console.log("Loading data from: " + url);
            req.open("GET", url);
            req.send();
            reqInProgress = true;
        }
        else {
            console.log("Key for World Weather Online API missing!");
            networkErrorDialog.open();
        }
    }
}

function dismissRequest()
{
    reqInProgress = false;
    req.abort();
}
