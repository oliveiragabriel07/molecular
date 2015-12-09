module Molecular
  class Subscription < ActiveRecord::Base
    enum status: [:queued, :sent, :rejected, :spam, :unsub, :bounced,
                  :soft_bounced]

    belongs_to :campaign
    belongs_to :recipient
    has_many :events

    def deliver
      events.create(label: 'queued')
      Mailer.campaign_email(campaign, self).deliver_now
    end
  end
end
