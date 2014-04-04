class Scan < ActiveRecord::Base
  belongs_to :user
  has_many :tweets, :dependent => :destroy
  has_one :twitter_detail, :dependent => :destroy

  @@stream_running

  def initialize_twitter_stream
    @client = Tweet.initialize_streaming_twitter_client

    topics = ["coffee", "tea"]
    i = 0
    @@stream_running = true
    @client.filter(:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text if object.is_a?(Twitter::Tweet)
        parse_and_save_tweet(object) if object.is_a?(Twitter::Tweet)
        puts i.to_s
        i+= 1
      end
      break if i >= 100
    end
    @@stream_running = false
  end

  def stream_running
    @@stream_running
  end

  def stream_running=(bool)
    @@stream_running = bool
  end

  def run
    @client = Tweet.initialize_twitter_client
    puts "Scan: #{self.id} - Twitter Client established"
    # return unless user_exsts?

    get_users_statuses
    puts "Scan: #{self.id} - Tweets Retrieved and Processed"

    # get_users_connections

  end

  # def user_exsts?
  #   # begin
  #     @user = @client.user(self.username)
  #     self.error = "Success"
  #     self.twitter_detail = TwitterDetail.new(TwitterDetail.user_attributes(@user))
  #     true
  #   # rescue
  #   #   self.error = "Does Not Exist"
  #   #   false
  #   # end
  # end

  def get_users_statuses
    return if self.twitter_detail.protected_tweets

    sentiment_analyzer = Sentimental.new

    full_tweets = Tweet.get_all_tweets_for_user(self.username)
    total_score = 0
    total_sentiment = 0

    full_tweets.each do |t|

      # Create Tweet Objects
      new_tweet = Tweet.new(text: t.full_text, tweet_time: t.created_at,
                            twitter_id: t.id, scan_id: self.id)

      # Set geolocation if applicable
      new_tweet.has_geo = t.geo? ? new_tweet.record_geolocation(t.geo) : false

      # Scan for Sentimentality
      total_sentiment += new_tweet.score_sentimentality(sentiment_analyzer)

      # Scan for Obscenities
      total_score += new_tweet.count_obscenities

      # Scan for Hashtags, Mentions, and Links
      new_tweet.start_twitter_text_scan

      # Find popular links - instagram, twitpic
      # Find all people mentioned
      # Common words used

      new_tweet.save
    end
    self.score = total_score
    self.average_sentiment = total_sentiment / self.tweets.count
  end

  def get_users_connections
    # GET friends/list -> Following usernames+descriptions
    # GET followers/list -> Followers
    # GET users/lookup -> hydrated user object
    # Check if mentioned people are verified
  end

  def total_dirty_word_count
    x = 0
    self.tweets.each{|i| i.dirty_word_count + x}
    x
  end

  def parse_and_save_tweet(twitter_object)
    return if twitter_object.nil?

    sentiment_analyzer = Sentimental.new

    # Create Tweet Objects
    new_tweet = Tweet.new(text: twitter_object.full_text,
                          tweet_time: twitter_object.created_at,
                          twitter_id: twitter_object.id,
                          scan_id: self.id)

    # Set geolocation if applicable
    new_tweet.has_geo = twitter_object.geo? ? new_tweet.record_geolocation(twitter_object.geo) : false

    # Scan for Sentimentality
    new_tweet.score_sentimentality(sentiment_analyzer)

    # Scan for Obscenities
    new_tweet.count_obscenities

    # Scan for Hashtags, Mentions, and Links
    new_tweet.start_twitter_text_scan

    # Find popular links - instagram, twitpic
    # Find all people mentioned
    # Common words used

    new_tweet.save
  end

end
