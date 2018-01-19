require 'rails_helper'

RSpec.describe Unit, type: :model do
  it "should reject a unit whose parent is from a different culture" do
    u = Unit.create(
      innoculated: Date.today - 3.days,
      medium: FactoryBot.create(:medium),
      culture: FactoryBot.create(:culture),
      parent: FactoryBot.create(:unit,
        culture: FactoryBot.create(:culture)))

    expect(u.valid?).to eq false
  end

  it "should accept a unit with a valid culture" do
    u = Unit.create(
      innoculated: Date.today - 3.days,
      medium: FactoryBot.create(:medium),
      culture: FactoryBot.create(:culture))

    expect(u.valid?).to eq true
  end

  describe "uuid" do
    it "should have the correct form of uuid"
  end

  describe "generation" do
    it "should return 0 for a Unit without a parent"
    it "should always be 1 greater than the generation of its parent"
  end
end
