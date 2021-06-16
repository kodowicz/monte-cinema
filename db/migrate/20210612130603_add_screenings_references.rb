class AddScreeningsReferences < ActiveRecord::Migration[6.1]
  def up
    add_reference :screenings, :display_type, null: false, foreign_key: true
    add_reference :screenings, :voice_type, null: false, foreign_key: true
  end

  def down
    remove_reference :screenings, :display_type, null: false, foreign_key: true
    remove_reference :screenings, :voice_type, null: false, foreign_key: true
  end
end
