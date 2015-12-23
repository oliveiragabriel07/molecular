FactoryGirl.define do
  factory :molecular_campaign, aliases: [:campaign],
                               class: 'Molecular::Campaign' do
    owner
    subject "subject"
    body "body"
    from 'from@example'
    from_name 'From Example'
    sent_at nil

    factory :campaign_with_subscriptions do
      transient do
        subscriptions_count 5
      end

      after(:create) do |campaign, evaluator|
        create_list(:subscription, evaluator.subscriptions_count,
                    campaign: campaign)
      end
    end
  end
end
