require "molecular/engine"

module Molecular
  # Use as Molecular.owner_class
  # def mattr_accessor :owner_class
  # def self.owner_class
  #   @@owner_class.constantize
  # end

  def self.setup
    yield self
  end
end
