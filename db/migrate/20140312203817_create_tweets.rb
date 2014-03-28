class CreateTweets < ActiveRecord::Migration
  def change
    create_table  :tweets do |t|
      t.text      :text
      t.string    :twitter_id
      t.timestamp :tweet_time
      t.integer   :score
      t.references :scan, index: true
      t.float     :sentiment_score
      t.string    :sentiment_summary
      t.text      :html

      t.timestamps
    end
  end
end
