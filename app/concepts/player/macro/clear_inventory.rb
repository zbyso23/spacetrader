module Player::Macro::ClearInventory
  def self.call
    ->(ctx, player:, **) do
      player.player_inventories.destroy_all
      true
    end
  end
end