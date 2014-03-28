class Link < ActiveRecord::Base
  has_many :link_tweets
  has_many :tweets, through: :link_tweets
end
