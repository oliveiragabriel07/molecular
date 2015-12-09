# Extends Mandrill::WebHook::EventDecorator with app-specific event payload
# transformation
class Mandrill::WebHook::EventDecorator
  # Returns the subscription_id of the associated record (if available)
  def subscription_id
    metadata['subscription_id']
  end

  def bounce_description
    msg['bounce_description']
  end

  def status
    Molecular::Subscription.statuses[msg['state'].try(:gsub, "-", "_")]
  end
end
