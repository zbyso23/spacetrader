class CreateLoanShark < ActiveRecord::Migration[7.0]
  def change
    create_table :loan_sharks do |t|
      t.references :planet, null: false, foreign_key: true
      t.decimal :base_interest, precision: 10, scale: 2, default: 20.0
      t.integer :reputation_required, null: false, default: 1
      t.integer :reputation_premium, null: false, default: 10

      t.timestamps
    end
  end
end
