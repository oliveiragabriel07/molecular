# Extends Mandrill::WebHook::EventDecorator with app-specific event payload
# transformation
class Mandrill::WebHook::EventDecorator
  # Returns the subscription_id of the associated record (if available)
  def subscription_id
    metadata['subscription_id']
  end

  def subscription_status
    Molecular::Subscription.statuses[msg['state'].try(:gsub, "-", "_")]
  end

  def to_event_params
    {label: event_type, triggered_at: triggered_at, value: value,
     subscription_id: subscription_id, payload: to_s}
  end

  def value
    case event_type.to_sym
    when :click
      self['url']
    when :hard_bounce, :soft_bounce
      bounce_description
    end
  end

  def bounce_description
    msg['bounce_description']
  end

  def triggered_at
    Time.at(self['ts']).utc.to_datetime
  end
end
