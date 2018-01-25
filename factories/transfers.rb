FactoryBot.define do
  factory :transfer do
    ### Attributes ###
    weight 1.32
    count 3
    notes "This transfer was conducted in a factory."
    datetime { DateTime.now }
    medium { FactoryBot.create(:medium) }

    ### Transfer kinds ###
    transient          do; has_parent true; end
    trait :has_culture do; has_parent false; end

    culture do
      FactoryBot.create(:culture) unless has_parent
    end

    parent do
      FactoryBot.create(:tissue_unit) if has_parent
    end

    trait :tissue_kind do
      kind 'tissue'
    end

    ### Factories ###
    factory :tissue_transfer, traits: [:has_culture, :tissue_kind]
  end
end
