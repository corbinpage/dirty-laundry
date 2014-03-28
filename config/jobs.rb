require File.expand_path("../environment", __FILE__)

job "scan.run" do |args|
  Scan.find(args["id"]).run
end

# beanstalkd
# stalk ./config/jobs.rb
# rails server