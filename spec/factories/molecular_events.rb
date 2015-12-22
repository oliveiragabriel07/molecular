FactoryGirl.define do
  factory :molecular_event, aliases: [:event], class: 'Molecular::Event' do
    subscription
    label ""

    trait :click do
      label "click"
      value "https://github.com/oliveiragabriel07/molecular"
    end

    trait :open do
      label "open"
    end
  end
end
