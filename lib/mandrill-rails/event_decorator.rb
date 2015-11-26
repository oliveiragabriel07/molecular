# Extends Mandrill::WebHook::EventDecorator with app-specific event payload
# transformation
class Mandrill::WebHook::EventDecorator
  # Returns the list_id of the associated list record (if available)
  def list_id
    self['msg']['metadata']['list_id']
  end
end
