require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "uuid" do
    it "should have the correct form of uuid when blank"
    it "should have the correct form of uuid when innoculated"
  end

  describe "generation" do
    it "should return 0 for a Unit without a parent"
    it "should always be 1 greater than the generation of its parent"
  end
end
