class User::Contract::Create < Reform::Form
  feature Reform::Form::ActiveModel

  property :name
  property :email

  validates :name, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end