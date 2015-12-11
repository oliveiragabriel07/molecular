FactoryGirl.define do
  factory :molecular_campaign, aliases: [:campaign],
                               class: 'Molecular::Campaign' do
    owner
    subject "subject"
    body "body"
  end
end
