class RemoveNullfalseSongGaps < ActiveRecord::Migration
  def up
    change_column :songs, :song_gap, :integer, null: true
  end

  def down
    change_column :songs, :song_gap, :integer, null: false
  end
end
