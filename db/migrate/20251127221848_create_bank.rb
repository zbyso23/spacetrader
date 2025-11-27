class CreateBank < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.references :planet, null: false, foreign_key: true
      t.decimal :base_interest, precision: 10, scale: 2, default: 2.0
      t.integer :reputation_required, null: false, default: 5
      t.integer :reputation_premium, null: false, default: 25

      t.timestamps
    end
  end
end
