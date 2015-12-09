module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    has_many :subscriptions

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
  end
end
