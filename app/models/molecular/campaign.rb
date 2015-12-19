module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    has_many :subscriptions

    validates :subject, presence: true
    validates :body, presence: true
    validates :owner, presence: true
    validates :from, presence: true
    validates :from_name, presence: true

    def enqueue
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

    def open_rate
      100 * subscriptions.opened.to_a.size.to_f / subscriptions.count
    end

    def click_rate
      100 * subscriptions.clicked.to_a.size.to_f / subscriptions.count
    end

    def unique_opens
      subscriptions.opened.to_a.size
    end

    def unique_clicks
      subscriptions.clicked.to_a.size
    end
  end
end
