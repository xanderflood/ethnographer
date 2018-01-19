FactoryBot.define do
  factory :unit do
    culture { FactoryBot.create(:cultures) }
    innoculated { Date.today - 3.days }
  end
end
