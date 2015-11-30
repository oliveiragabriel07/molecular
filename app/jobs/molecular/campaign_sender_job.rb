module Molecular
  class CampaignSenderJob < ActiveJob::Base
    queue_as :campaigns

    def perform(campaign)
      Rails.logger.debug "#{self.class.name}: Performing campaign sender " \
        "job with campaign: #{campaign.inspect}"

      campaign.recipients.find_each do |u|
        recipient = Molecular::Recipient.find_or_create_by(email: u.email)
        Rails.logger.debug "#{self.class.name}: Queuing campaign to " \
          "#{recipient.inspect}"

        # TODO: avoid duplicate email by checking if it was already sent
        # list = campaign.lists.create(recipient: recipient)

        Mailer.campaign_email(campaign, recipient).deliver_now
        # TODO: check if this is needed
        Molecular::Event.create(list: list, label: 'queued')
      end
    end
  end
end
