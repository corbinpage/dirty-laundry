class TwitterDetail < ActiveRecord::Base
  belongs_to :user
  # validates :twitter_uid, uniqueness: true

  def self.omniauth_attributes(omniauth)
    attribute_hash = {}
    attribute_hash[:twitter_uid] = omniauth.uid
    attribute_hash[:oauth_token] = omniauth.credentials.token
    attribute_hash[:oauth_token_secret] = omniauth.credentials.secret
    if omniauth.info
      attribute_hash[:description] = omniauth.info.description
      attribute_hash[:profile_image_url] = omniauth.info.image
      attribute_hash[:location] = omniauth.info.location
      attribute_hash[:name] = omniauth.info.name
      attribute_hash[:user_name] = omniauth.info.nickname
      attribute_hash[:website_url] = omniauth.info.urls.Website
      attribute_hash[:twitter_url] = omniauth.info.urls.Twitter
    end
    if omniauth.extra && omniauth.extra.raw_info
      attribute_hash[:account_created_at] = omniauth.extra.raw_info.created_at
      attribute_hash[:favorites_count] = omniauth.extra.raw_info.favourites_count
      attribute_hash[:followers_count] = omniauth.extra.raw_info.followers_count
      attribute_hash[:following_count] = omniauth.extra.raw_info.friends_count
      attribute_hash[:total_tweets] = omniauth.extra.raw_info.statuses_count
      attribute_hash[:background_image_url] = omniauth.extra.raw_info.profile_background_image_url
    end
    attribute_hash
  end

end
