class AddNullFalseToSongPicks < ActiveRecord::Migration
  def up
      change_column :predictions, :set_one_opener_song_id, :integer, null: false
      change_column :predictions, :set_one_closer_song_id, :integer, null: false
      change_column :predictions, :set_two_opener_song_id, :integer, null: false
      change_column :predictions, :set_one_closer_song_id, :integer, null: false
      change_column :predictions, :encore_song_id, :integer, null: false
      change_column :predictions, :random_pick_song_id, :integer, null: false
  end

  def down
      change_column :predictions, :set_one_opener_song_id, :integer, null: true
      change_column :predictions, :set_one_closer_song_id, :integer, null: true
      change_column :predictions, :set_two_opener_song_id, :integer, null: true
      change_column :predictions, :set_one_closer_song_id, :integer, null: true
      change_column :predictions, :encore_song_id, :integer, null: true
      change_column :predictions, :random_pick_song_id, :integer, null: true
  end
end
