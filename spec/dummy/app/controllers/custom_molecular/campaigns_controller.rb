class CustomMolecular::CampaignsController < Molecular::CampaignsController
  def index
    flash[:notice] = "Custom campaigns controller" \
    " Owner is #{molecular_owner.email}"
    super
  end
end
