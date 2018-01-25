require 'rails_helper'

RSpec.describe Transfer, type: :model do
  before :all do
    @medium  = FactoryBot.create(:medium)
    @culture = FactoryBot.create(:culture)
    @parent  = FactoryBot.create(:tissue_unit)
  end

  it "should create and use a medium if attributes are provided" do
    name = rand.to_s
    t = Transfer.tissue.create(culture: @culture, count: 1, medium_attributes: { name: name })

    expect(t.units.first.medium.name).to eq name
  end

  context "with kind == transfer" do
    it "should create children of Transfer#parent" do
      t = Transfer.transfer.create(parent: @parent, count: 3, medium: @medium)

      expect(t.units.count).to eq 3
      t.units.each do |unit|
        expect(t.parent).to eq @parent
      end
    end
  end

  context "with kind == tissue" do
    it "should fail if no culture is given" do
      t = Transfer.tissue.create(count: 3, medium: @medium)

      expect(t.errors.count).to eq 1
      expect(t.errors[:culture]).to eq ["must be specified"]
    end

    it "should create top-level children" do
      t = Transfer.create(kind: :tissue, count: 3, medium: @medium, culture: @culture)

      expect(t.units.count).to eq 3
      t.units.each do |unit|
        expect(t.parent).to eq nil
      end
    end

    it "should create and use a culture if attributes are provided" do
      name = rand.to_s
      t = Transfer.tissue.create(medium: @medium, count: 1, culture_attributes: { name: name })

      expect(t.units.first.culture.name).to eq name
    end
  end

  context "with kind == spores"
  context "with kind == isolate"
end
