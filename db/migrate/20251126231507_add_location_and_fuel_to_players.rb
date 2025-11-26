class AddLocationAndFuelToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :current_planet, foreign_key: { to_table: :planets }
    add_column :players, :fuel, :integer, default: 100
  end
end
