FactoryGirl.define do
  factory :molecular_subscription, aliases: [:subscription],
                                   class: 'Molecular::Subscription' do
    campaign
    recipient
  end
end
