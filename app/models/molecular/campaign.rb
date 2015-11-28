module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    def enqueue
      Molecular::CampaignSenderJob.perform_later self
    end
  end
end
