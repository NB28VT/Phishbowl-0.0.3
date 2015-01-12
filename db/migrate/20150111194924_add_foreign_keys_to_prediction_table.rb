class AddForeignKeysToPredictionTable < ActiveRecord::Migration
  def up
    add_column :predictions, :user_id, :integer
    add_column :predictions, :concert_id, :integer
  end

  def down
    remove_column :predictions, :user_id
    remove_column :predictions, :concert_id
  end
end
