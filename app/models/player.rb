class Player < ApplicationRecord
  belongs_to :user
  belongs_to :current_planet, class_name: 'Planet', optional: true
  has_many :player_inventories, dependent: :destroy
  has_many :goods, through: :player_inventories
  
  validates :name, presence: true
end