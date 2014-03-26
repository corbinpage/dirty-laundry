class Scan < ActiveRecord::Base
  belongs_to :user
  has_many :tweets, :dependent => :destroy
  has_one :twitter_detail, :dependent => :destroy

  def run
    @client = Tweet.initialize_twitter_client
    return unless user_exsts?

    get_users_statuses

    get_users_connections

  end

  def user_exsts?
    # begin
      @user = @client.user(self.username)
      self.error = "Success"
      self.twitter_detail = TwitterDetail.new(TwitterDetail.user_attributes(@user))
      true
    # rescue
    #   self.error = "Does Not Exist"
    #   false
    # end
  end

  def get_users_statuses
    return if self.twitter_detail.protected_tweets

    sentiment_analyzer = Sentimental.new

    full_tweets = Tweet.get_all_tweets_for_user(self.username)
    total_score = 0
    total_sentiment = 0
    full_tweets.each do |t|
      new_tweet = Tweet.new(text: t.full_text, tweet_time: t.created_at,
                            twitter_id: t.id, scan_id: self.id)
      
      #Scan for Obscenities
      dirty_words = Obscenity.offensive(t.full_text)
      if(dirty_words.count > 0)
        new_tweet.score = dirty_words.count
        total_score += new_tweet.score
        new_tweet.dirty_words = dirty_words.join(', ')
        new_tweet.get_tweet_html
      else
        new_tweet.score = 0
      end

      new_tweet.sentiment_score = sentiment_analyzer.get_score(t.full_text)
      total_sentiment = new_tweet.sentiment_score
      new_tweet.sentiment_summary = sentiment_analyzer.get_sentiment(t.full_text)
      new_tweet.save
    end
    self.score = total_score
    self.average_sentiment = total_sentiment / self.tweets.count
    # GET statuses/user_timeline -> can get 200 at a time total
    # GET statuses/retweets_of_me -> most retweets if you want
  end

  def get_users_connections
    # GET friends/list -> Following usernames+descriptions
    # GET followers/list -> Followers
    # GET users/lookup -> hydrated user object
  end

end
