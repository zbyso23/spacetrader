class Player::Operation::AddStartItems < Trailblazer::Operation
  step :create_items

  def create_items(_ctx, model:, **)
    return true unless model.persisted?

    water   = Good.find_by(name: 'Water')
    protein = Good.find_by(name: 'Protein')

    model.player_inventories.create!(good: water,   quantity: 10, quality: 50)
    model.player_inventories.create!(good: protein, quantity: 5,  quality: 50)
    true
  end
end
