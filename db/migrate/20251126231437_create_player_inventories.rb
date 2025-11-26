class CreatePlayerInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :player_inventories do |t|
      t.references :player, null: false, foreign_key: true
      t.references :good, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.integer :quality, null: false, default: 50 # 1-100

      t.timestamps
    end

    add_index :player_inventories, [:player_id, :good_id], unique: true
  end
end
