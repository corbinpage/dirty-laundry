# Loads various services needed for the application

# Setup Twitter Service
Tweet.initialize_twitter_client

#Load sentimentality analyzer
Sentimental.load_defaults
Sentimental.threshold = 0.1

#Load Obscenity analyzer
Obscenity.configure do |config|
  config.blacklist   = "config/blacklist.yml"
  config.whitelist   = ["kittens"]
  config.replacement = :garbled
end