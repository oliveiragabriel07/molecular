FactoryGirl.define do
  factory :molecular_subscription, aliases: [:subscription],
                                   class: 'Molecular::Subscription' do
    campaign
    recipient
    opens_count 0
    clicks_count 0
  end
end
