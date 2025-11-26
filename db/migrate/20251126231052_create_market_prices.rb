class CreateMarketPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :market_prices do |t|
      t.references :planet, null: false, foreign_key: true
      t.references :good, null: false, foreign_key: true
      t.integer :buy_price, null: false
      t.integer :sell_price, null: false
      t.integer :quality, null: false, default: 50 # 1-100
      t.integer :stock, default: 1000 # stock

      t.timestamps
    end

    add_index :market_prices, [:planet_id, :good_id], unique: true
  end
end
