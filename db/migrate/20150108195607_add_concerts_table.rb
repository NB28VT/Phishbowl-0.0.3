class AddConcertsTable < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :venue, null:false
      t.string :venue, null:false
      t.datetime :date_time, null: false

      t.timestamps
    end
  end
end
