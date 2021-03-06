require 'rails_helper'

RSpec.describe Unit, type: :model do
  it "should set culture to that of parent, even if another is specified" do
    u = Unit.create(
      innoculated: Date.today - 3.days,
      medium: FactoryBot.create(:medium),
      culture: FactoryBot.create(:culture),
      parent: FactoryBot.create(:unit,
        culture: FactoryBot.create(:culture)))

    expect(u.culture).to eq u.parent.culture
  end

  it "should accept a unit with a valid culture" do
    u = Unit.create(
      innoculated: Date.today - 3.days,
      medium: FactoryBot.create(:medium),
      culture: FactoryBot.create(:culture))

    expect(u.valid?).to eq true
  end

  describe "uuid" do
    it "should have the correct form of uuid" do
      units = [FactoryBot.create(:tissue_unit)]
      cid   = units.first.culture_id.to_s

      for _ in 1..4 do
        units << FactoryBot.create(:unit, parent: units.last)
      end

      code = ""
      units.each.with_index do |unit, i|
        parts = unit.uuid.split("-")

        expect(parts.count).to eq 2
        expect(parts[0]).to eq cid

        code += (i % 2 == 0) ? "A" : "0"
        expect(parts[1]).to eq code
      end

      unit = FactoryBot.create(:unit, parent: units[3])
      expect(unit.uuid).to eq(units[3].uuid + "B")
    end

    it "should properly increment for multiple tissue clones" do
      culture = FactoryBot.create(:culture)
      medium = FactoryBot.create(:medium)

      alphas = ("A".."Z").to_a
      for i in 1..4 do
        unit = Unit.create(culture: culture, medium: medium)

        expect(unit.uuid[-1]).to eq alphas[i-1]
      end
    end
  end

  describe "generation" do
    it "should return 0 for a Unit without a parent" do
      u = FactoryBot.create(:tissue_unit, parent: nil)

      expect(u.generation).to eq 0
    end

    it "should always be 1 greater than the generation of its parent" do
      u = FactoryBot.create(:tissue_unit)
      g = u.generation

      u2 = FactoryBot.create(:unit, parent: u)
      expect(u2.generation).to eq(u.generation + 1)

      u3 = FactoryBot.create(:unit, parent: u2)
      expect(u3.generation).to eq(u2.generation + 1)

      u4 = FactoryBot.create(:unit, parent: u3)
      expect(u4.generation).to eq(u3.generation + 1)

      u5 = FactoryBot.create(:unit, parent: u4)
      expect(u5.generation).to eq(u4.generation + 1)

      u6 = FactoryBot.create(:unit, parent: u4)
      expect(u6.generation).to eq(u5.generation)
    end
  end
end
