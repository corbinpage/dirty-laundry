class Mention < ActiveRecord::Base
  has_many :mention_tweets
  has_many :tweets, through: :mention_tweets
end
