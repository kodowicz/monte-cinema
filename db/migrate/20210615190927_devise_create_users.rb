class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :username, default: ""
      t.integer :age, null: false, default: 0
      t.text :avatar, default: ""
      t.boolean :real_user, null: false, default: true
      t.integer :role, null: false, default: 0

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def down 
    remove_index :users, :email, unique: true
    remove_index :users, :reset_password_token, unique: true
    drop_table :users
  end
end
