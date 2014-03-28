class CreateMentionTweets < ActiveRecord::Migration
  def change
    create_table :mention_tweets do |t|
      t.references :tweet
      t.references :mention

      t.timestamps
    end
  end
end
