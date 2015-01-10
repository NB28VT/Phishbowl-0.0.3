class FixShowdateConcertTable < ActiveRecord::Migration
  def up
    remove_column :concerts, :date_time
    add_column :concerts, :concert_date, :string, null: false
  end

  def down
    add_column :concerts, :date_time, :datetime, null: false
    remove_column :concerts, :concert_date
  end
end
