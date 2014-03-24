class CreateScans < ActiveRecord::Migration
  def change
    create_table  :scans do |t|
      t.string    :username
      t.integer   :score
      t.string    :error
      t.integer   :user_id
      t.float     :average_sentiment

      t.timestamps
    end
  end
end
