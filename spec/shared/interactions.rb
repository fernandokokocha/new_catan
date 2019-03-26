# frozen_string_literal: true

RSpec.shared_examples 'not mutating interaction' do
  it "doesn't change the state object" do
    old = game.state
    call
    new = game.state
    expect(new).to be(old)
  end

  it "doesn't change the state values" do
    old_values = game.state.values
    call
    new_values = game.state.values
    expect(new_values).to eq(old_values)
  end
end
