class CreateHashtagTweets < ActiveRecord::Migration
  def change
    create_table :hashtag_tweets do |t|
      t.references :tweet
      t.references :hashtag

      t.timestamps
    end
  end
end
