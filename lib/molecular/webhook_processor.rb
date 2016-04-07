module Molecular
  class WebhookProcessor
    def self.run(payload)
      subscription = Subscription.find_by(id: payload.subscription_id)
      return unless subscription
      # updates subscription
      subscription.update(status: payload.subscription_status) if
        payload.subscription_status
      # create new event
      Event.create(payload.to_event_params)
    end
  end
end
