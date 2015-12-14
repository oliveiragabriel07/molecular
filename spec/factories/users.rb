FactoryGirl.define do
  factory :user, aliases: [:owner], class: 'User' do
    sequence(:email) { |n| "person#{n}@example.com".downcase }
  end
end
