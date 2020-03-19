class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title
      t.date :starts_at
      t.date :ends_at
      t.text :description
      t.boolean :private

      t.timestamps
    end
  end
end
