class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :label, null: false
      t.timestamps null: false
    end
  end
end
