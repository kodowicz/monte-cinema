class ChangeClientsToUsers < ActiveRecord::Migration[6.1]
  def up
    remove_reference :reservations, :client, null: false, foreign_key: true
    add_reference :reservations, :user, null: false, foreign_key: true
    drop_table :clients
  end

  def down
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.boolean :real_user

      t.timestamps
    end

    add_reference :reservations, :client, null: false, foreign_key: true
    remove_reference :reservations, :user, null: false, foreign_key: true
  end
end
