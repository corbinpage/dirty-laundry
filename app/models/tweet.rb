class Tweet < ActiveRecord::Base
  belongs_to :scan
  scope :chart1, -> {select("count(id)").where('scan_id = 3').group('STRFTIME("%m-%Y",tweet_time)').order(tweet_time: :asc)}

  @@client

  SKETCH_METER_CONSUMER_KEY = ENV['SKETCH_METER_CONSUMER_KEY']
  SKETCH_METER_CONSUMER_SECRET = ENV['SKETCH_METER_CONSUMER_SECRET']

  def self.initialize_twitter_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_CONSUMER_KEY
      config.consumer_secret  = SKETCH_METER_CONSUMER_SECRET
    end
  end

  def self.client
    @@client
  end

  def self.get_all_tweets_for_user(username)
    all_tweets = Tweet.client.user_timeline(username, count: 200)
    # :max_id
    # since_id - Gets tweets since a given ID

    more_tweets_available = all_tweets.count >= 200

    while more_tweets_available
      more_tweets = Tweet.client.user_timeline(username, count: 200, max_id: all_tweets.last.id)
      all_tweets += more_tweets
      more_tweets_available = more_tweets.count == 200
    end
    all_tweets
  end

end
