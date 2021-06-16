class CreateVoiceTypes < ActiveRecord::Migration[6.1]
  def up
    create_table :voice_types do |t|
      t.string :name, default: "original"

      t.timestamps
    end
  end

  def down
    drop_table :voice_types
  end
end
