class FixNullFalseInPredictionTable < ActiveRecord::Migration
  def up
    change_column :predictions, :set_two_closer_song_id, :integer, null: false
    change_column :predictions, :concert_id, :integer, null: false
    change_column :predictions, :user_id, :integer, null: false
  end

  def down
    change_column :predictions, :set_two_closer_song_id, :integer, null: true
    change_column :predictions, :concert_id, :integer, null: true
    change_column :predictions, :user_id, :integer, null: true
  end
end
