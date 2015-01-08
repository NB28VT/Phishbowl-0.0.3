class AddPredictions < ActiveRecord::Migration

  def change
      create_table :predictions do |t|
        t.string :set_one_opener, null: false
        t.string :set_one_closer, null: false
        t.string :set_two_opener, null: false
        t.string :set_two_closer, null: false
        t.string :encore, null: false
      end
    end
end
