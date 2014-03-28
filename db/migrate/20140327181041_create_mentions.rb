class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string :text

      t.timestamps
    end
    add_index :mentions, :text
  end
end
