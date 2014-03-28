class AddGeoToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :has_geo, :boolean
    add_column :tweets, :lat, :float
    add_column :tweets, :lng, :float
    add_index  :tweets, :twitter_id
  end
end
