FactoryGirl.define do
  factory :molecular_campaign, aliases: [:campaign],
                               class: 'Molecular::Campaign' do
    owner
    subject "subject"
    body "body"
    from 'from@example'
    from_name 'From Example'
  end
end
