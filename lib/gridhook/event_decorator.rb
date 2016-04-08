# Extends Gridhook::Event with app-specific event transformation
class Gridhook::EventDecorator
  SENDGRID_EVENT_MAP = {
    processed: :queued,
    deferred: :deferral,
    delivered: :send,
    bounce: :hard_bounce,
    dropped: :rejected,
    spamreport: :spam,
    unsubscribe: :unsub
  }

  def initialize(event)
    @event = event
  end

  # Returns the subscription_id of the associated record (if available)
  def subscription_id
    @event.attributes[:subscription_id]
  end

  def subscription_status
    case @event.name.to_sym
    when :dropped
      Molecular::Subscription.statuses[:rejected]
    when :delivered
      Molecular::Subscription.statuses[:sent]
    when :bounce
      Molecular::Subscription.statuses[:bounced]
    when :spamreport
      Molecular::Subscription.statuses[:spam]
    when :unsubscribe
      Molecular::Subscription.statuses[:unsub]
    end
  end

  def to_event_params
    {label: label, triggered_at: @event.timestamp, value: value,
     subscription_id: subscription_id, payload: to_s}
  end

  def label
    SENDGRID_EVENT_MAP[@event.name.to_sym] || @event.name.to_sym
  end

  def value
    case @event.name.to_sym
    when :click
      @event.attributes[:url]
    when :bounce, :dropped
      @event.attributes[:reason]
    end
  end
end
