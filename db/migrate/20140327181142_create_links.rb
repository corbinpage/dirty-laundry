class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :text

      t.timestamps
    end
    add_index :links, :text
  end
end
