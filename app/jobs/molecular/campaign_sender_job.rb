module Molecular
  class CampaignSenderJob < ActiveJob::Base
    queue_as :campaigns

    def perform(campaign)
      campaign.recipients.find_each do |u|
        recipient = Molecular::Recipient.find_or_create_by(email: u.email)

        list = campaign.lists.find_or_initialize_by(recipient: recipient)
        next unless list.new_record?

        list.save
        list.events.create(label: 'queued')
        Mailer.campaign_email(campaign, list).deliver_now
      end
    end
  end
end
