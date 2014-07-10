#!/usr/bin/env ruby

["landscapeNoTabs", "landscapeWithTabs", "noTabs", "withTabs"].each do |folder|

  system("cp config/#{folder}/application.coffee config")
  system("cp config/#{folder}/cloud.json.#{ARGV[0]} config/cloud.json")
  system("cp config/#{folder}/rotations.js www/javascripts")

  if ARGV[0] == "test"
  	system("steroids deploy --ankaURL=http://anka.testgyver.com --shareURL=http://share.testgyver.com --authURL=http://accounts.testgyver.com")
  else
  	system("steroids deploy")
  end
  
end