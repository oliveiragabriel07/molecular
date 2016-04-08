require "molecular/engine"

module Molecular
  # Address which sends Molecular e-mails.
  mattr_accessor :mailer_sender

  def self.setup
    yield self
  end
end

require "molecular/controller_additions"
require "molecular/webhook_processor"
require "mandrill-rails/event_decorator"
require "gridhook/event_decorator"
