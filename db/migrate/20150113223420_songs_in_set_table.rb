class SongsInSetTable < ActiveRecord::Migration
  def up
    add_column :concert_songs, :songs_in_set, :integer, null: false
  end

  def down
    remove_column :concert_songs, :songs_in_set
  end
end
