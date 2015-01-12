class ChangePredictionTableToSongIds < ActiveRecord::Migration
  def up
    add_column :predictions, :set_one_opener_song_id, :integer
    add_column :predictions, :set_one_closer_song_id, :integer
    add_column :predictions, :set_two_opener_song_id, :integer
    add_column :predictions, :set_two_closer_song_id, :integer
    add_column :predictions, :encore_song_id, :integer
    add_column :predictions, :random_pick_song_id, :integer

    remove_column :predictions, :set_one_opener
    remove_column :predictions, :set_one_closer
    remove_column :predictions, :set_two_opener
    remove_column :predictions, :set_two_closer
    remove_column :predictions, :encore
    remove_column :predictions, :random_song
  end

def down
    remove_column :predictions, :set_one_opener_song_id
    remove_column :predictions, :set_one_closer_song_id
    remove_column :predictions, :set_two_opener_song_id
    remove_column :predictions, :set_two_closer_song_id
    remove_column :predictions, :encore_song_id
    remove_column :predictions, :random_pick_song_id

    add_column :predictions, :set_one_opener, :string
    add_column :predictions, :set_one_closer, :string
    add_column :predictions, :set_two_opener, :string
    add_column :predictions, :set_two_closer, :string
    add_column :predictions, :encore, :string
    add_column :predictions, :random_song, :string
  end
end
