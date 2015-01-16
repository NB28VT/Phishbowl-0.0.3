class CreateConcertSongsTable < ActiveRecord::Migration
  def change
    create_table :concert_songs do |t|
      t.integer :song_id, null: false
      t.integer :play_index, null: false
      t.integer :set_index, null: false
      t.integer :concert_id, null: false
    end
  end
end
