module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    def enqueue
      # TODO: add campaign to perform queue
    end
  end
end
