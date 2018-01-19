require 'rails_helper'

RSpec.describe Medium, type: :model do
  it 'should accept valid attributes' do
    expect do
      Medium.create!(name: "My favorite growth medium",
        recipe: "Mostly just regular potatoes")
    end.not_to raise_error
  end
end
