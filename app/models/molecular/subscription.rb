module Molecular
  class Subscription < ActiveRecord::Base
    enum status: [:queued, :sent, :rejected, :spam, :unsub, :bounced,
                  :soft_bounced]

    belongs_to :campaign
    belongs_to :recipient
    has_many :events, dependent: :destroy

    validates :campaign, presence: true
    validates :recipient, presence: true

    scope :opened, -> { where('opens_count > ?', 0) }
    scope :clicked, -> { where('clicks_count > ?', 0) }
    scope :with_most_opens, lambda { |max = 5|
      opened.order("opens_count desc").limit(max)
    }

    def update_counter_cache!
      update(opens_count: events.opens.count, clicks_count: events.clicks.count)
    end

    def deliver
      events.create_queued
      Mailer.campaign_email(id, campaign, recipient).deliver_now
    end
  end
end
