class AddSongTable < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_name, null: false
      t.string :artist_name, null: false
      t.integer :song_gap, null: false

      t.timestamps
    end
  end
end
