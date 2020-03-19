class CreateEntertainments < ActiveRecord::Migration
  def change
    create_table :entertainments do |t|
      t.date :when
      t.text :description
      t.string :place
      t.belongs_to :trip, index: true

      t.timestamps
    end
  end
end
