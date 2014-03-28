class WordTweet < ActiveRecord::Base
  belongs_to :word
  belongs_to :tweet
end
