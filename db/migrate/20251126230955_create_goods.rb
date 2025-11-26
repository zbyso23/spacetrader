class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|
      t.string :name, null: false
      t.text :description
      
      t.timestamps
    end
    
    add_index :goods, :name, unique: true
  end
end
