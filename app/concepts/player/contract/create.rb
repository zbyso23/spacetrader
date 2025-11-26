class Player::Contract::Create < Reform::Form
  feature Reform::Form::ActiveModel

  property :name
  property :user_id

  validates :name, presence: true
  validates :user_id, presence: true
end