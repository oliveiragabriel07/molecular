require_dependency "molecular/application_controller"

module Molecular
  class EventsController < ApplicationController
    include Mandrill::Rails::WebHookProcessor
    ignore_unhandled_events!

    def handle_open(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_click(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload).merge(value: payload['url']))
    end

    def handle_spam(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_unsub(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_reject(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_send(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_deferral(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload))
    end

    def handle_hard_bounce(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload)
        .merge(value: payload.bounce_description))
    end

    def handle_soft_bounce(payload)
      return unless load_and_update_subscription(payload)
      Event.create(event_params(payload)
        .merge(value: payload.bounce_description))
    end

    private
      def event_params(payload)
        {
          label: payload['event'],
          triggered_at: Time.at(payload['ts']).utc.to_datetime,
          subscription_id: payload.subscription_id,
          payload: payload.to_s
        }
      end

      def load_and_update_subscription(payload)
        return unless payload.subscription_id
        subscription = Subscription.find(payload.subscription_id)
        subscription.update(status: payload.status) if payload.status
        subscription
      end
  end
end
