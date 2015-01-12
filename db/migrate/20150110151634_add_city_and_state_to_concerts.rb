class AddCityAndStateToConcerts < ActiveRecord::Migration
  def up
    add_column :concerts, :city, :string, null: false
    add_column :concerts, :state, :string, null: false
  end

  def down
    remove_column :concerts, :city
    remove_column :concerts, :state
  end
end
