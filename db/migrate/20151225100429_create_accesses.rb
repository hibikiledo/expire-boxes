class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :box, index: true
      t.string :role, null: false
      t.timestamps null: false
    end
  end
end
