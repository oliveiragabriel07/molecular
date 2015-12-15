module Molecular
  class Subscription < ActiveRecord::Base
    enum status: [:queued, :sent, :rejected, :spam, :unsub, :bounced,
                  :soft_bounced]

    belongs_to :campaign
    belongs_to :recipient
    has_many :events

    validates :campaign, presence: true
    validates :recipient, presence: true

    scope :with_most_opens, lambda { |record_limit = 5|
      joins(:events).where(molecular_events: {label: 'open'}).
        group(:subscription_id).order("count(molecular_events.id) desc").
        limit(record_limit)
    }

    # FIXME: add after_save callback to event to upgrade opens count
    scope :opened, lambda {
      distinct.joins(:events).where(molecular_events: {label: 'open'}).
        group("molecular_events.id").having("count(molecular_events.id) > 0")
    }

    # FIXME: add after_save callback to event to upgrade clicks count
    scope :clicked, lambda {
      joins(:events).where(molecular_events: {label: 'click'}).
        group("molecular_events.id").having("count(molecular_events.id) > 0")
    }

    def deliver
      events.create(label: 'queued')
      Mailer.campaign_email(id, campaign, recipient).deliver_now
    end
  end
end
