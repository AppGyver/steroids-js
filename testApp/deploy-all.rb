#!/usr/bin/env ruby

["landscapeNoTabs", "landscapeWithTabs", "noTabs", "withTabs"].each do |folder|

  system("cp config/#{folder}/application.coffee config")
  system("cp config/#{folder}/cloud.json config")
  system("cp config/#{folder}/rotations.js www/javascripts")

  system("steroids deploy")

end