class Hashtag < ActiveRecord::Base
  has_many :hashtag_tweets
  has_many :tweets, through: :hashtag_tweets
end
