require 'rails_helper'

RSpec.describe Transfer, type: :model do
  [:medium, :culture].each do |field|
    describe field do
      it "should accept attributes, and create"
    end
  end

  context "when type is transfer" do
    it "should create children of Transfer#parent"
  end

  context "when type is tissue" do
    it "should create top-level children"
  end

  context "when type is spores"
  context "when type is isolate"
end
