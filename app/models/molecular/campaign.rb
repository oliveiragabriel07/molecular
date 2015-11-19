module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    # TODO: add CampaignDecorator to install inscript containing the method bellow
    #
    # private
    #   def recipients
    #     raise NotImplementedError, "Campaign must implement recipients method"
    #   end
  end
end
