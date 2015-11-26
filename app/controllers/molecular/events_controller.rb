require_dependency "molecular/application_controller"

module Molecular
  class EventsController < ApplicationController
    include Mandrill::Rails::WebHookProcessor

    private
      def handle_open(payload)
        # puts "--- OPEN ----------------------------------"
        # puts payload.inspect
        Event.create(label: payload['event'], list_id: payload.list_id)
      end

      def handle_click(payload)
        # puts payload.inspect
      end

      def handle_spam(event_payload)
        # puts payload.inspect
      end

      def handle_unsub(payload)
        # puts payload.inspect
      end

      def handle_reject(payload)
        # puts payload.inspect
      end

      def handle_sync(payload)
        # puts payload.inspect
      end

      def handle_send(payload)
        # puts payload.inspect
      end

      def handle_deferral(payload)
        # puts payload.inspect
      end

      def handle_hard_bounce(payload)
        # puts payload.inspect
      end

      def handle_soft_bounce(payload)
        # puts payload.inspect
      end
  end
end
