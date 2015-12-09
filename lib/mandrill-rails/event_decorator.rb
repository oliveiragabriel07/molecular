# Extends Mandrill::WebHook::EventDecorator with app-specific event payload
# transformation
class Mandrill::WebHook::EventDecorator
  # Returns the list_id of the associated list record (if available)
  def list_id
    metadata['list_id']
  end

  def bounce_description
    msg['bounce_description']
  end

  def status
    Molecular::List.statuses[msg['state'].try(:gsub, "-", "_")]
  end
end
