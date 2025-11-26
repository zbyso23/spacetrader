class PlayerInventory < ApplicationRecord
  belongs_to :player
  belongs_to :good
  
  validates :quantity, :quality, presence: true
  validates :quality, inclusion: { in: 1..100 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end