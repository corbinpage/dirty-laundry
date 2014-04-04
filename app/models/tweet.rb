class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  belongs_to :scan
  has_many :word_tweets
  has_many :words, through: :word_tweets
  has_many :mention_tweets
  has_many :mentions, through: :mention_tweets
  has_many :hashtag_tweets
  has_many :hashtags, through: :hashtag_tweets
  has_many :link_tweets
  has_many :links, through: :link_tweets
  # scope :chart1, -> {select("count(id)").where('scan_id = 3').group('STRFTIME("%m-%Y",tweet_time)').order(tweet_time: :asc)}


  SKETCH_METER_CONSUMER_KEY = ENV['SKETCH_METER_CONSUMER_KEY']
  SKETCH_METER_CONSUMER_SECRET = ENV['SKETCH_METER_CONSUMER_SECRET']

  def self.initialize_twitter_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key     = SKETCH_METER_CONSUMER_KEY
      config.consumer_secret  = SKETCH_METER_CONSUMER_SECRET
    end
  end

  def self.initialize_streaming_twitter_client
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key     = SKETCH_METER_CONSUMER_KEY
      config.consumer_secret  = SKETCH_METER_CONSUMER_SECRET
      config.access_token        = ""
      config.access_token_secret = ""
    end
  end



  def self.get_all_tweets_for_user(username)
    all_tweets = @@client.user_timeline(username, count: 200, exclude_replies: true, include_rts: false)
    # :max_id
    # since_id - Gets tweets since a given ID

    more_tweets_available = all_tweets.count >= 3

    while more_tweets_available
      more_tweets = @@client.user_timeline(username, count: 200, max_id: all_tweets.last.id, exclude_replies: true, include_rts: false)
      all_tweets += more_tweets
      more_tweets_available = more_tweets.count >= 3
    end
    all_tweets
  end

  def self.client
    @@client
  end

  def count_obscenities
    dirty_words = Obscenity.offensive(self.text)
    if(dirty_words.count > 0)
      self.score = dirty_words.count
      self.get_tweet_html
      dirty_words.each do |w|
        self.words.push(Word.find_or_create_by(text: w))
      end
    else
      self.score = 0
    end
    return self.score
  end

  def score_sentimentality(sentiment_analyzer)
    self.sentiment_summary = sentiment_analyzer.get_sentiment(self.text)
    self.sentiment_score = sentiment_analyzer.get_score(self.text)
  end

  def record_geolocation(geo)
    self.lat = geo.coordinates[0]
    self.lng = geo.coordinates[1]
    true
  end

  def start_twitter_text_scan
    # Extract Mentions
    extract_mentioned_screen_names(self.text).each do |w|
      self.mentions.push(Mention.find_or_create_by(text: w))
    end

    # Extract Links
    extract_urls(self.text).each do |w|
      self.links.push(Link.find_or_create_by(text: w))
    end

    # Extract Hashtags
    extract_hashtags(self.text).each do |w|
      self.hashtags.push(Hashtag.find_or_create_by(text: w))
    end
  end

  def obscenity_count
    self.obscenities.count
  end

  def risque_string=(name_arr)
    @risque_string = name_arr.join(', ')
  end

  def risque_string
    @risque_string
  end

  def get_tweet_html
    begin
      tweet = Tweet.client.oembed(self.twitter_id)
      self.html = tweet.html.gsub(/<script(.*?)$/,'') # Trims everything after the s cript tag
      puts "Tweet scanned"
    rescue
      puts "Tweet scan fail"
      # raise "HTML scan limit reached for embedded Tweets."
    end
  end

  # Could be Deprecateds
  # def self.get_all_tweets_html(twitter_ids)
  #   tweets = self.client.oembeds(twitter_ids)
  #   hash = {}
  #   tweets.each {|t| hash[t.url.split('statuses/')[1]] = t.html}
  #   hash
  # end

end
