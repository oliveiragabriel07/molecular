module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    has_many :subscriptions
    has_many :events, through: :subscriptions

    validates :subject, presence: true
    validates :body, presence: true
    validates :owner, presence: true
    validates :from, presence: true
    validates :from_name, presence: true

    def enqueue
      update(sent_at: Time.zone.now)
      Molecular::CampaignSenderJob.perform_later self
    end

    # create a new subscription for recipient if it does not exist
    # return subscription if created, nil otherwise
    def subscribe(recipient)
      subscription = subscriptions.find_or_initialize_by(recipient: recipient)
      return unless subscription.new_record?
      subscription.save
      subscription
    end

    def sent?
      sent_at.present?
    end

    # OPTIMIZE: extract to a decorator?
    def open_rate
      100 * unique_opens.to_f / (subscriptions.count.nonzero? || 1)
    end

    def click_rate
      100 * unique_clicks.to_f / (subscriptions.count.nonzero? || 1)
    end

    def unique_opens
      subscriptions.opened.to_a.size
    end

    def unique_clicks
      subscriptions.clicked.to_a.size
    end

    def total_opens
      events.where(label: 'open').count
    end

    def total_clicks
      events.where(label: 'click').count
    end

    def last_open
      events.where(label: 'open').order(triggered_at: :desc).first
    end

    def last_click
      events.where(label: 'click').order(triggered_at: :desc).first
    end

    def bounces_count
      subscriptions.bounced.count + subscriptions.soft_bounced.count
    end

    def rejected_count
      subscriptions.rejected.count
    end

    def delivered_count
      subscriptions.sent.count
    end

    def pending_count
      subscriptions.queued.count
    end
  end
end
