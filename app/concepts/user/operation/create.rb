class User::Operation::Create < Trailblazer::Operation
  step :build_contract
  step :validate_contract
  step :persist

  def build_contract(ctx, params:, **)
    ctx[:contract] = User::Contract::Create.new(User.new)
    ctx[:contract].validate(params)
  end

  def validate_contract(ctx, contract:, **)
    contract.valid?
  end

  def persist(ctx, contract:, **)
    contract.save
  end
end
