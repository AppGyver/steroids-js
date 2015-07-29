
################### DEVELOPERS PLEASE NOTE ###################
###                                                        ###
### Any changes made to application.coffee should also be  ###
###      made to the application.coffee files under the    ###
###                    following folders:                  ###
###                                                        ###
###                  config/landscapeNoTabs                ###
###                 config/landscapeWithTabs               ###
###                       config/noTabs                    ###
###                      config/withTabs                   ###
###                                                        ###
########################## THANK YOU #########################


# -- Required settings --

steroids.config.name = "Steroids.js test app (with tabs)"
steroids.config.location = "http://localhost/views/steroids/index.html"


# -- Tabs --

# A boolean to enable tab bar (on bottom)
# This will override steroids.config.location (that is for single webview apps, like in PhoneGap)
# Default: false
#
steroids.config.tabBar.enabled = true

# Array with objects to specify which tabs are created on app startup
#
# Tab object properties are:
# - title: text to show in tab title
# - icon: path to icon file (f.e. images/icon@2x.png)
# - location: can be one of these
#   - file URL (relative to www, f.e. index.html)
#   - http://localhost:13101/ (serves files locally from www, f.e. http://localhost:13101/ would serve index.html)
#   - http://www.google.com (directly from internet)
#
steroids.config.tabBar.tabs = [
  {
    id: "tab-http"
    title: "HTTP"
    icon: "icons/pill@2x.png"
    location: "http://localhost/views/steroids/index.html"
  }
  {
    id: "tab-fileurl"
    title: "FileURL"
    icon: "icons/shoebox@2x.png"
    location: "views/steroids/index.html"
  }
  {
    id: "tab-nojs"
    title: "noJS"
    icon: "icons/shoebox@2x.png"
    location: "nojs.html"
  }
  {
    id: "tab-cordova"
    title: "Cordova"
    icon: "icons/telescope@2x.png"
    location: "http://localhost/views/plugin/index.html"

    navigationBar:
      title: "Cordova TAB"
      buttons:
        right: [{
          title: "CDV"
          id: "cdvButton"
        }]
  }
  {
    id: "tab-config"
    title: "Config-iOS"
    icon: "icons/shoebox@2x.png"
    location: "http://localhost/views/config/index.html"
  }
]

steroids.config.preloads = [
  {
    id: "preloadedViaPreloadsArray"
    location: "http://localhost/views/webview/preloadedViaPreloadsArray.html"
    navigationBar:
      title: "From the config ;-)"
      id : "myCssId"
      styleClass : "myCssClas"
      styleCSS: "color: #fff;background-color:red;"
      overrideBackButton:true

      backButton:
        title: "<<"
        id: "myCustomBackButton"
        styleClass: "customBackCssClass"

      buttons:
        right: [{
          title: "right"
          id: "myRightButton"
          styleClass: "customBackCssClass"
        }]

  }
]

# -- Drawer test --
steroids.config.drawers =
  left:
    id: "leftDrawer"
    location: "http://localhost/views/drawers/leftDrawer.html"
    showOnAppLoad: false    # true breaks on iOS
    widthOfDrawerInPixels: 300
  right:
    id: "rightDrawer"
    location: "http://localhost/views/drawers/rightDrawer.html"
    showOnAppLoad: false    # true breaks on iOS
    widthOfDrawerInPixels: 200
  options:
   #   centerViewInteractionMode: "Full"   # NOT SUPPORTED ON ANDROID
    closeGestures: ["PanBezelCenterView", "TapCenterView"] # Only PanBezelCenterView and TapCenterView are available in Android
    openGestures: ["PanBezelCenterView"] # Only PanBezelCenterView is supported in Android
    showShadow: true
    scrimColor: "#0FEC0F0D" # ANDROID ONLY
    # No harm in using High values ..it will not make the scrolling worse then
    # the default behaviour of Drawer Layout...
    diagonalThreshold: -2   # ANDROID ONLY
    verticalThreshold: 3.5  # ANDROID ONLY
   #   stretchDrawer: true   # NOT SUPPORTED ON ANDROID
   #   widthOfLayerInPixels: 0

###
# -- Initial View ---
steroids.config.initialView =
  id: "initialView"
  location: "http://localhost/views/initview/index.html"
###

# -- Status bar --
# Sets status bar visible (carrier, clock, battery status)
# Default: false
#
steroids.config.statusBar.enabled = Math.random() > 0.5

# -- Colors --
# Color values can be set in hex codes, eg. #ffbb20
# Setting these values override values set by the application theme in steroids.config.theme
# Default for all attributes: ""

# steroids.config.navigationBar.tintColor = ""
# steroids.config.navigationBar.titleColor = ""

# steroids.config.navigationBar.buttonTintColor = ""
# steroids.config.navigationBar.buttonTitleColor = ""

steroids.config.navigationBar.borderSize = 4
steroids.config.navigationBar.borderColor = "#aef"

# steroids.config.tabBar.tintColor = ""
# steroids.config.tabBar.tabTitleColor = ""
# steroids.config.tabBar.selectedTabTintColor = ""

# Can be used to set an indicator image for the selected tab (can be bigger than the tab)
# Default: ""
# steroids.config.tabBar.selectedTabBackgroundImage = ""

# Built-in iOS theme, values: black and default
# Default: "default"
#
# steroids.config.theme = "default"

# The preMake command is run before `steroids make`, the process where `app/` and `www/` folders are processed into the `dist/` folder.
# steroids.config.hooks.preMake.cmd = "grunt"
# steroids.config.hooks.preMake.args = ["build"]
#
# The postMake command is run right after `steroids make`, before running `steroids package`, the process that packages the app before sending it to client devices.
# steroids.config.hooks.postMake.cmd = "echo"
# steroids.config.hooks.postMake.args = ["cleaning up files"]

steroids.config.copyToUserFiles = ["test.txt", "test.png"]
