## 2.7.11 (2013-11-15)

Tab improvements, navigation bar bugfixes

Features:
  - Adds support for tabBar parameter in steroids.layers.push

Bugfixes:
  - Fixes the issue Android right button not showing.
  - Navigation bar title image and image buttons now wait for the Steroids `ready` event internally.

## 2.7.10 (2013-10-17)

Multiple navigation bar buttons, ability to hide the back button.

Features:
  - `steroids.view.navigationBar.setButtons()` API expanded, see the [API docs](http://docs.appgyver.com/en/edge/steroids_Steroids%20Native%20UI_steroids.view.navigationBar_navigationBar.setButtons.md.html#steroids.view.navigationBar.setButtons) for more information
    - Hide/show the back button.
    - Multiple buttons on the left and right side of the navigation bar.
    - Buttons can use images or text.

## 2.7.9 (2013-10-14)

Initial Tizen support.

Features:
  - TizenBridge for handling API calls and auto-refresh of client on Tizen devices.

## 2.7.8 (2013-09-27)

Grunt tasks updated to latest Node.js version, support for images in navigation bar (iOS only)

Changes:
  - Added support for images in navigation bar with steroids.view.navigationBar.show({titleImagePath: imagePath})
  - Cleaned up and updated `grunt` tasks to support Node.js 0.10.x/0.11.x

## 2.7.7 (2013-08-21)

Fixed a bug that prevented Steroids API calls from functioning on certain Android versions.

Bugfixes:
  - WebBridge is no longer erroneously used instead of NativeBridge (affected certain Android versions)

## 2.7.6 (2013-08-19)

SQLite API no longer experimental

Changes:
  - steroids.data.SQLiteDB.createTable supports defining columns as an object

## 2.7.5 (2013-08-08)

Experimental EventSource support for refreshing browser when project is changed

Changes:
  - WebBridge polls steroids npm for changes and refreshes

## 2.7.4 (2013-08-08)

Expirimental SQLite API and browser support

Changes:
  - steroids.data.SQLliteDB secret APIs
  - Experimental support for browser debugging

## 2.7.3 (2013-08-02)

Experimental TouchDB API

Changes:
  - steroids.data.TouchDB secret APIs

## 2.7.2 (2013-07-12)

Bugfixes:
  - fixed rare issue with websocket state handling

## 2.7.1 (2013-06-04)

Sleep modes and layer stack replacing

Changes:
  - steroids.layers.replace all layers with a preloaded webview
  - steroids.device.disableSleep - prevent device's screen from sleeping
  - steroids.device.enableSleep - allow device's screen to sleep

## 2.7.0 (2013-06-03)

Public beta release

## 0.7.1 (2013-05-07)

Tuned drawers animations.

Changes:
 - Left drawer animation is snappier

## 0.7.0 (2013-05-06)

Version bumb to 0.7.x indicate dependency on new Scanner.

## 0.6.2 (2013-05-02)

Drawers.

Features:
  - steroids.drawers namespace with methods for managing drawers.

## 0.6.1 (2013-04-08)

Reset changelog.

Bugfixes:
  - API calls were broken in 0.6.0, release process failure.

