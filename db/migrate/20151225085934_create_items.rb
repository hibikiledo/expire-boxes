class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :box, index: true
      t.string :label, null: false
      t.date :expire_date, null: false
      t.integer :amount, null: false
      t.timestamps null: false
    end
  end
end
