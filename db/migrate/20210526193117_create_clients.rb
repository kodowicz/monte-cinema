class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.boolean :real_user
      
      t.timestamps
    end
  end
end
