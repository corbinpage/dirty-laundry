# namespace :server do
#   desc "Start server ith beanstalk dependencies"
#   task :start do
#   # task :start => :environment do
#     puts "Starting up Server..."
#     `beanstalkd`
#     puts "Beanstalk Complete..."
#     # sleep(2)
#     `stalk ./config/jobs.rb`
#     puts "Stalk Complete..."
#     # sleep(2)
#     `rails server`
#   end
# end