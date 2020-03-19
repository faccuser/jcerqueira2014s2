class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.belongs_to :trip, index: true

      t.timestamps
    end
  end
end
