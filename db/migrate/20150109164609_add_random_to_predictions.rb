class AddRandomToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :random_song, :string
  end
end
