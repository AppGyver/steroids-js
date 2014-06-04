#!/usr/bin/env ruby

["landscapeNoTabs", "landscapeWithTabs", "noTabs", "withTabs"].each do |folder|

  system("cp config/#{folder}/application.coffee config")
  system("cp config/#{folder}/cloud.json.#{ARGV[0]} config/cloud.json")
  system("cp config/#{folder}/rotations.js www/javascripts")

  system("steroids deploy")

end