module Molecular
  class CampaignSenderJob < ActiveJob::Base
    queue_as :molecular_campaigns

    def perform(campaign)
      # update campaing status
      campaign.update(sent_at: Time.zone.now) unless campaign.sent_at.present?

      campaign.recipients.find_each do |u|
        recipient = Molecular::Recipient.find_or_create_by(email: u.email)

        subscription = campaign.subscribe(recipient)
        subscription.try(:deliver)
      end
    end
  end
end
