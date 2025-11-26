class CreatePlanets < ActiveRecord::Migration[7.0]
  def change
    create_table :planets do |t|
      t.string :name, null: false
      t.string :planet_type, null: false # 'planet' or 'moon'
      t.boolean :has_bank, default: false
      t.boolean :has_fixed_quality, default: false # fixed quality

      t.timestamps
    end

    add_index :planets, :name, unique: true
  end
end
