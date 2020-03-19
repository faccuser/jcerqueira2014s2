class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.text :description
      t.string :price
      t.belongs_to :trip, index: true

      t.timestamps
    end
  end
end
