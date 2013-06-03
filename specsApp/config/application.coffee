# -- Required settings --
# Name of the application, used as the app name when creating a build

steroids.config.name = "SpecsApp"

# -- Location: steroids.config.location --
# Defines the location of the HTML document that the initial steroids.views.WebView will render (for applications without the tab bar).
# Enabling the tab bar via 'steroids.config.tabBar.enabled = true' will override this value.
# The location can be one of these:
#   - file URL (serves the document via the file protocol from the www/ folder, e.g. 'index.html' would serve www/index.html, )
#   - localhost URL, starting with http://localhost/ (serves the document locally from the www/ folder, e.g. 'http://localhost/index.html' would serve www/index.html)
#   - external URL (directly from the internets, e.g. http://www.google.com)

steroids.config.location = "http://localhost/views/runner/index.html"

# -- Remote hosts: steroids.config.hosts --
# Defines the hostnames that the application will capture and serve application files from.
# E.g. by adding mobileapp.example.com to the list, http://mobileapp.example.com/index.html will be served locally, just like http://localhost/index.html.
# Default: []
#
# steroids.config.hosts = ["mobileapp.example.com", "m.example.net"]

# -- Enabling tabs --
#
# A boolean to enable the native tab bar.
# Enabling tabs will override steroids.config.location (which is inteded for single WebView apps, i.e. PhoneGap's default behavior) and show the first tab of the tab array on startup.
# Default: false
#
# steroids.config.tabBar.enabled = true

# -- Defining tabs via the tab array --
# An array of tab objects that specify which tabs are created on app startup.
#
# Tab object properties are:
# - title: text to show in the tab title
# - icon: path to the tab's icon file, relative to www/ (e.g. icons/pill@2x.png) (iOS only)
#   - adding '@2x' before the file extension in the icon's filename allows proper handling of Retina images
# - location: defines which HTML document the tab's initial steroids.views.WebView will render, can be one of these:
#   - file URL (serves the document via the file protocol from the www/ folder, e.g. 'index.html' would serve www/index.html, )
#   - localhost URL, starting with http://localhost/ (serves the document locally from the www/ folder, e.g. 'http://localhost/index.html' would serve www/index.html)
#   - external URL (directly from the internets, e.g. http://www.google.com)

#
# steroids.config.tabBar.tabs = [
#   {
#     title: "Index"
#     icon: "icons/pill@2x.png"
#     location: "http://localhost/index.html"
#   },
#   {
#     title: "Internet"
#     icon: "icons/telescope@2x.png"
#     location: "http://www.google.com"
#   }
# ]

# -- Status bar --
# Sets the visibilty of the status bar on iOS (shows the carrier, clock and battery status)
# Default: false

steroids.config.statusBar.enabled = true

# -- Colors --
# Color values can be set in hex codes, eg. #ffbb20
# Setting these values will override the values set by the application theme in steroids.config.theme
# Default for all attributes: ""

steroids.config.navigationBar.tintColor = "#00aeef"
steroids.config.navigationBar.titleColor = "#ffffff"
steroids.config.navigationBar.titleShadowColor = "#000000"

steroids.config.navigationBar.buttonTintColor = "#363636"
steroids.config.navigationBar.buttonTitleColor = "#ffffff"
steroids.config.navigationBar.buttonShadowColor = "#000000"

# steroids.config.tabBar.tintColor = ""
# steroids.config.tabBar.tabTitleColor = ""
# steroids.config.tabBar.tabTitleShadowColor = ""
# steroids.config.tabBar.selectedTabTintColor = ""
#
# -- Indicator image --
# Can be used to set an indicator image for the selected tab on iOS (can be bigger than the tab area)
# Default: ""
#
# steroids.config.tabBar.selectedTabBackgroundImage = ""
#
# -- iOS theme --
# Built-in iOS theme, values: black and default
# Default: "default"
#
# steroids.config.theme = "default"