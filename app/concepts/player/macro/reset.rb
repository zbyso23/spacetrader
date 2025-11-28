module Player::Macro::Reset
  def self.call
    ->(ctx, player:, **) do
      starting_planet = Planet.find_by(name: "Mars")

      player.update!(
        current_planet: starting_planet,
        fuel: 100,
        credit: 1000,
        reputation: 1
      )
    end
  end
end