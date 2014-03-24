class User < ActiveRecord::Base
  has_many :authentications
  has_many :scans
  has_one :twitter_detail

  def self.omniauth_attributes(omniauth)
    {name: omniauth.info.name, username: omniauth.info.nickname}
  end

end
