class CreateTables < ActiveRecord::Migration
  def up
    create_table "properties", :force => true do |t|
      t.string   "title"
      t.string   "description"
      t.integer  "x"
      t.integer  "y"
      t.integer  "price"
      t.integer  "beds"
      t.integer  "baths"
      t.integer  "square_meters"
      t.string   "provinces"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table :properties
  end
end
