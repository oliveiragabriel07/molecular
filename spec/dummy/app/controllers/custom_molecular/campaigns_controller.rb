class CustomMolecular::CampaignsController < Molecular::CampaignsController
  def index
    Rails.logger.debug "Custom campaigns controller" \
                       " Owner is #{molecular_owner.email}"
    super
  end
end
