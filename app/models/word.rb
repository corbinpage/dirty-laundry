class Word < ActiveRecord::Base
  has_many :word_tweets
  has_many :tweets, through: :word_tweets
end
