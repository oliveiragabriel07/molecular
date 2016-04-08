Gridhook.configure do |config|
  config.event_receive_path = '/sendgrid/event'
  config.event_processor = proc do |event|
    Molecular::WebhookProcessor.run(Gridhook::EventDecorator.new(event))
  end
end
