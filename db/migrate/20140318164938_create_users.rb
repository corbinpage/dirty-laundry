class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :name

      # ## Rememberable
      # t.datetime :remember_created_at

      # ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :email,                   unique: true
    add_index :users, :username,                unique: true
  end
end
