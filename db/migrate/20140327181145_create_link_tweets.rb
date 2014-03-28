class CreateLinkTweets < ActiveRecord::Migration
  def change
    create_table :link_tweets do |t|
      t.references :tweet
      t.references :link

      t.timestamps
    end
  end
end
