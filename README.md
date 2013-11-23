Weather Forecast
================

Weather Forecast is a Nokia Developer example application that has been ported 
from Windows Phone to Qt. This simple Qt Quick application parses the weather 
forecast content from XML data retrieved over the network.

In addition, the example demonstrates how to implement internationalisation
with Qt and Qt Quick. Four languages are supported: English, Finnish, German, and
Polish.

This example application is hosted in GitHub:
https://github.com/nokia-developer/weather-forecast

For more information on implementation and porting, visit the wiki pages:
* https://github.com/nokia-developer/weather-forecast/wiki
* https://github.com/nokia-developer/weather-forecast/wiki/Porting-Weather-Forecast-from-Windows-Phone-to-Qt

The Weather Forecast Sample for Windows Phone can be found from Microsoft's
MSDN Library at http://msdn.microsoft.com/en-us/library/ff431744.aspx

<img src="https://raw.github.com/nokia-developer/weather-forecast/master/doc/wf-qt-splash-screen.png" width="200px" /> 


1. Usage
-------------------------------------------------------------------------------

The example supports a test mode which is enabled by default in the code.
In the test mode, the data is retrieved from a static file deployed with the
application instead of fetching it from the network.

To disable the test mode, uncomment the "DEFINES += TEST_MODE" line in the project
file and add your personal World Weather Online API key to the
qml/common/Constants.js file. Refer to the project wiki for more information.

In the binaries delivered with the project, the test mode is disabled and the
data is retrieved from the online weather service.


2. Project structure and implementation
-------------------------------------------------------------------------------

2.1 Folders
-----------

```
|                  The root folder contains the project file, resource files,
|                  the license information, and this file (release notes).
|
|-data             Application-specific data,  e.g. XML data for test mode.
|
|- doc             Documentation.
|
|- gfx             Contains application graphics.
|
|- icons           Contains application icons.
|
|- loc             Contains the localisation files.
|
|- qml             Root folder for QML and Javascript files.
|  |
|  |- common       Common, cross-platform QML and Javascript files.
|  |
|  |- harmattan    Harmattan-specific QML and Javascript files.
|  |
|  |- symbian      Symbian-specific QML and Javascript files.
|
|- qtc_packaging   Contains the Harmattan (Debian) packaging files.
|
|- rsc             Contains the resource files.
|
|- src             Contains the Qt/C++ source code files.
```

2.2 Important Qt Quick Components
---------------------------------

* `ListHeading`
* `ListModel`
* `ListView`
* `SelectionDialog`: Used in settings page (SettingsPage.qml), supported only on Symbian 
* `SelectionListItem`: Used in settings page (SettingsPage.qml)
* `XmlListModel`: Used in forecast page (ForecastPage.qml)
 
See Qt Quick Components reference documentation for further details.


3. Compatibility
-------------------------------------------------------------------------------

* Symbian devices with Qt 4.7.4 and Qt Quick Components 1.1 or higher.
* MeeGo 1.2 Harmattan.

Tested to work on Nokia C7-00, Nokia N8-00, Nokia X7-00, and Nokia N9.
Developed with Qt SDK 1.1.4.


3.1 Required capabilities
-------------------------

Only the basic capabilities. The application can be self signed on Symbian.


3.2 Known issues
----------------

* The font size is bigger in the Simulator than on a Symbian device. This issue
  breaks the layout in the forecast page in the Simulator (the delegates
  overlap).
   
* On Harmattan, the items displayed in the selection dialog on the settings
  page are not localised. This is due to the fact that on Harmattan, the
  SelectionDialog component does not support QStringList to be used as a model.
  If you wish to localise the items in the model, implement a custom model
  derived from QAbstractListModel.

* Changing orientation between landscape and portrait causes a failure in
  setting the list offset. This is because the layout of the items differ
  depending on the orientation.


4. Building, installing, and running the application
-------------------------------------------------------------------------------

4.1 Preparations
----------------

Check that you have the latest Qt SDK installed in the development environment
and the latest Qt version on the device.

Qt Quick Components 1.0 or higher is required.

4.2 Using the Qt SDK
--------------------

You can install and run the application on the device by using the Qt SDK.
Open the project in the SDK, set up the correct target (depending on the device
platform), and click the Run button. For more details about this approach,
visit the Qt Getting Started section at Nokia Developer
(http://www.developer.nokia.com/Develop/Qt/Getting_started/).

4.3 Symbian device
------------------

Make sure your device is connected to your computer. Locate the .sis
installation file and open it with Nokia Suite. Accept all requests from Nokia 
Suite and the device. Note that you can also install the application by copying
the installation file onto your device and opening it with the Symbian File
Manager application.

After the application is installed, locate the application icon from the
application menu and launch the application by tapping the icon.

4.4 Nokia N9 and Nokia N950
---------------------------

Copy the application Debian package onto the device. Locate the file with the
device and run it; this will install the application. Note that you can also
use the terminal application and install the application by typing the command
`dpkg -i <package name>.deb` on the command line. To install the application
using the terminal application, make sure you have the right privileges 
to do so (e.g. root access).

Once the application is installed, locate the application icon from the
application menu and launch the application by tapping the icon.


5. License
-------------------------------------------------------------------------------

See the license text file delivered with this project. The license file is also
available online at
https://github.com/nokia-developer/weather-forecast/blob/master/Licence.txt


6. Version history
-------------------------------------------------------------------------------

1.0 Initial release
