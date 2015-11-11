require "molecular/engine"

module Molecular
  def self.setup
    yield self
  end
end
