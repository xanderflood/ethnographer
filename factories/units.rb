FactoryBot.define do
  factory :unit do
    culture { FactoryBot.create(:culture) }
    medium { FactoryBot.create(:medium) }
    innoculated { Date.today - 3.days }
  end
end
