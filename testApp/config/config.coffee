Steroids = require "steroids"

Steroids.config.name = "Steroids"
Steroids.config.location = "http://localhost:13101/views/layers/index.html"

#Steroids.config.statusBar.enabled = true
#Steroids.config.statusBar.style = "black" # options are: "default", "black" and "hidden"
Steroids.config.tabBar.enabled = true

#Steroids.config.worker.evalJS = "alert(1)"


Steroids.config.tabBar.tabs = [
 {
   title: "First"
   icon: "images/first@2x.png"
   location: "http://localhost:13101/views/audio/index.html"
 },
 {
   title: "Second"
   icon: "images/first@2x.png"
   location: "http://localhost:13101/views/layers/index.html"
 }
]

#Steroids.config.navigationBar.tintColor = ""
#Steroids.config.navigationBar.titleColor = ""
#Steroids.config.navigationBar.titleShadowColor = ""

#Steroids.config.navigationBar.buttonTitleColor = ""
#Steroids.config.navigationBar.buttonShadowColor = ""

#Steroids.config.tabBar.tintColor = ""
#Steroids.config.tabBar.tabTitleColor = ""
#Steroids.config.tabBar.tabTitleShadowColor = ""
#Steroids.config.tabBar.selectedTabTintColor = ""
#Steroids.config.tabBar.selectedTabBackgroundImage = ""

#Steroids.config.theme = "black"

module.exports = Steroids.config