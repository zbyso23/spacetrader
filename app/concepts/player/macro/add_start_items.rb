module Player::Macro::AddStartItems
  def self.call
    ->(ctx, player:, **) do
      water   = Good.find_by(name: "Water")
      protein = Good.find_by(name: "Protein")

      PlayerInventory.create!(player: player, good: water,   quantity: 10, quality: 50)
      PlayerInventory.create!(player: player, good: protein, quantity: 5,  quality: 50)

      true
    rescue => e
      ctx[:errors] = [e.message]
      false
    end
  end
end