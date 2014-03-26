class CreateTwitterDetails < ActiveRecord::Migration
  def change
    create_table  :twitter_details do |t|
      t.string    :oauth_token_secret
      t.string    :oauth_token
      t.datetime  :account_created_at
      t.string    :description
      t.integer   :favorites_count
      t.integer   :followers_count
      t.integer   :following_count
      t.string    :location
      t.string    :name
      t.string    :user_name
      t.string    :background_image_url
      t.string    :profile_image_url
      t.integer   :total_tweets
      t.string    :website_url
      t.string    :twitter_url
      t.string    :twitter_uid
      t.integer   :user_id
      t.integer   :scan_id
      t.boolean   :protected_tweets

      t.timestamps
    end
  end
end
