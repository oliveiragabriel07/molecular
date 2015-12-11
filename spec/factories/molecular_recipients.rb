require 'faker'

FactoryGirl.define do
  factory :molecular_recipient, aliases: [:recipient],
                                class: 'Molecular::Recipient' do
    name { Faker::Name.name }
    sequence(:email) { |n| "person#{n}@example.com".downcase }
  end
end
