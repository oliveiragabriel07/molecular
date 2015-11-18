class CustomMolecular::CampaignsController < Molecular::CampaignsController
  def index
    flash[:notice] = 'Custom campaigns controller'
    super
  end
end
