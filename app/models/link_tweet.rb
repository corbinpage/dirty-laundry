class LinkTweet < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :link
end
