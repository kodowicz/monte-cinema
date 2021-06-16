class CreateDisplayTypes < ActiveRecord::Migration[6.1]
  def up
    create_table :display_types do |t|
      t.string :name, default: "2D"

      t.timestamps
    end
  end

  def down
    drop_table :display_types
  end
end
