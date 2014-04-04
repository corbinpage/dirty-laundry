class TwitterDetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :scan
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

  def self.user_attributes(user_object)
    attribute_hash = {}
    attribute_hash[:name] = user_object.name
    attribute_hash[:profile_image_url] = user_object.profile_image_url.to_s.gsub('normal','bigger')
    attribute_hash[:background_image_url] = user_object.profile_banner_url_https.to_s
    attribute_hash[:account_created_at] = user_object.created_at
    attribute_hash[:location] = user_object.location
    attribute_hash[:favorites_count] = user_object.favorites_count
    attribute_hash[:followers_count] = user_object.followers_count
    attribute_hash[:description] = user_object.description
    attribute_hash[:following_count] = user_object.friends_count
    attribute_hash[:total_tweets] = user_object.statuses_count
    attribute_hash[:user_name] = user_object.username
    begin
      attribute_hash[:website_url] = user_object.to_h[:entities][:url][:urls][0][:expanded_url]
    rescue
      puts "No website found for " + user_object.username
    end
    attribute_hash[:twitter_uid] = user_object.id
    attribute_hash[:twitter_url] = user_object.url.to_s
    attribute_hash[:protected_tweets] = user_object.protected?

    attribute_hash
  end

end
