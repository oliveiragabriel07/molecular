require_dependency "molecular/application_controller"

module Molecular
  class EventsController < ActionController::Base
    include Mandrill::Rails::WebHookProcessor
    ignore_unhandled_events!

    def process_event(payload)
      Molecular::WebhookProcessor.run(payload)
    end

    alias_method :handle_soft_bounce, :process_event
    alias_method :handle_hard_bounce, :process_event
    alias_method :handle_deferral, :process_event
    alias_method :handle_send, :process_event
    alias_method :handle_reject, :process_event
    alias_method :handle_unsub, :process_event
    alias_method :handle_spam, :process_event
    alias_method :handle_click, :process_event
    alias_method :handle_open, :process_event
  end
end
