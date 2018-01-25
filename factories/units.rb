FactoryBot.define do
  factory :unit do
    medium { FactoryBot.create(:medium) }
    innoculated { Date.today - 3.days }

    transient           do; make_culture false; end
    trait :from_culture do; make_culture true;  end
    culture do
      if make_culture
        FactoryBot.create(:culture)
      else
        parent.culture
      end
    end

    factory :tissue_unit, traits: [:from_culture]
  end
end
