class User::Operation::New < Trailblazer::Operation
  step :build_contract

  def build_contract(ctx, **)
    ctx[:contract] = User::Contract::Create.new(User.new)
  end
end