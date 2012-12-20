Steroids = require "steroids"

Steroids.config.name = "Steroids"
Steroids.config.location = "http://localhost:13101/views/layers/index.html"

#Steroids.config.statusBar.enabled = true
#Steroids.config.statusBar.style = "black" # options are: "default", "black" and "hidden"
Steroids.config.tabBar.enabled = true

#Steroids.config.worker.evalJS = "alert(1)"

os = require 'os'

interfaces = os.networkInterfaces()
ips = []

for k of interfaces
  for k2 of interfaces[k]
    address = interfaces[k][k2]
    if address.family == 'IPv4' && !address.internal
      ips.push(address.address)

console.log "STEROIDS CLIENT USING IP #{ips[0]}"
Steroids.config.tabBar.tabs = [
 {
   title: "First"
   icon: "images/tabbar/native@2x.png"
   location: "http://#{ips[0]}:1111"
 },
 {
   title: "Second"
   icon: "images/tabbar/native@2x.png"
   location: "http://#{ips[0]}:1111"
 }
]

module.exports = Steroids.config
