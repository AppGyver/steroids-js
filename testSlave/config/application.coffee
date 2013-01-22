# -- Required settings --

Steroids.config.name = "Hello World"
Steroids.config.location = "index.html"

# -- Tabs --

# A boolean to enable tab bar (on bottom)
# This will override Steroids.config.location (that is for single webview apps, like in PhoneGap)
# Default: false
#
# Steroids.config.tabBar.enabled = true

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
# Steroids.config.tabBar.tabs = [
#   {
#     title: "Localhost"
#     icon: "icons/pill@2x.png"
#     location: "http://localhost:13101/views/pills/index.html"
#   },
#   {
#     title: "File URL"
#     icon: "icons/shoebox@2x.png"
#     location: "index.html"
#   },
#   {
#     title: "Internet"
#     icon: "icons/telescope@2x.png"
#     location: "http://www.google.com"
#   }
# ]



# -- Status bar --
# Sets status bar visible (carrier, clock, battery status)
# Default: false
#
# Steroids.config.statusBar.enabled = true



# -- Colors --
# Color values can be set in hex codes, eg. #ffbb20
# Setting these values override values set by the application theme in Steroids.config.theme
# Default for all attributes: ""

# Steroids.config.navigationBar.tintColor = ""
# Steroids.config.navigationBar.titleColor = ""
# Steroids.config.navigationBar.titleShadowColor = ""

# Steroids.config.navigationBar.buttonTintColor = ""
# Steroids.config.navigationBar.buttonTitleColor = ""
# Steroids.config.navigationBar.buttonShadowColor = ""

# Steroids.config.tabBar.tintColor = ""
# Steroids.config.tabBar.tabTitleColor = ""
# Steroids.config.tabBar.tabTitleShadowColor = ""
# Steroids.config.tabBar.selectedTabTintColor = ""

# Can be used to set an indicator image for the selected tab (can be bigger than the tab)
# Default: ""
# Steroids.config.tabBar.selectedTabBackgroundImage = ""

# Built-in iOS theme, values: black and default
# Default: "default"
#
# Steroids.config.theme = "default"
