class CreateTravelRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :travel_routes do |t|
      t.references :from_planet, null: false, foreign_key: { to_table: :planets }
      t.references :to_planet, null: false, foreign_key: { to_table: :planets }
      t.integer :fuel_cost, null: false
      t.integer :time_cost, null: false

      t.timestamps
    end

    add_index :travel_routes, [:from_planet_id, :to_planet_id], unique: true
  end
end
