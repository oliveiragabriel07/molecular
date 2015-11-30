module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    has_many :lists

    def enqueue
      Molecular::CampaignSenderJob.perform_later self
    end
  end
end
