class Tweet < ActiveRecord::Base
  belongs_to :scan
  scope :chart1, -> {select("count(id)").where('scan_id = 3').group('STRFTIME("%m-%Y",tweet_time)').order(tweet_time: :asc)}

  SKETCH_METER_CONSUMER_KEY = ENV['SKETCH_METER_CONSUMER_KEY']
  SKETCH_METER_CONSUMER_SECRET = ENV['SKETCH_METER_CONSUMER_SECRET']

  def self.initialize_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_CONSUMER_KEY
      config.consumer_secret  = SKETCH_METER_CONSUMER_SECRET
    end
  end

  def self.get_all_tweets_for_user(username)
    all_tweets = @client.user_timeline(username, count: 200, exclude_replies: true, include_rts: false)
    # :max_id
    # since_id - Gets tweets since a given ID

    more_tweets_available = all_tweets.count >= 10

    while more_tweets_available
      more_tweets = @client.user_timeline(username, count: 200, max_id: all_tweets.last.id, exclude_replies: true, include_rts: false)
      all_tweets += more_tweets
      more_tweets_available = more_tweets.count >= 10
    end
    all_tweets
  end

  def self.client
    @client
  end

  def get_tweet_html
    tweet = Tweet.client.oembed(self.twitter_id)
    self.html = tweet.html.gsub(/<script(.*?)$/,'') # Trims everything after the script tag
  end


  # Could be Deprecateds
  # def self.get_all_tweets_html(twitter_ids)
  #   tweets = self.client.oembeds(twitter_ids)
  #   hash = {}
  #   tweets.each {|t| hash[t.url.split('statuses/')[1]] = t.html}
  #   hash
  # end



end
