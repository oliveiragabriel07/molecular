module Molecular
  class CampaignSenderJob < ActiveJob::Base
    queue_as :campaigns

    def perform(campaign)
      campaign.recipients.find_each do |u|
        recipient = Molecular::Recipient.find_or_create_by(email: u.email)

        subscription = campaign.subscribe(recipient)
        subscription.try(:deliver)
      end

      # update campaing status
      campaign.update(sent_at: Time.zone.now)
    end
  end
end
