require 'spec_helper'

RSpec.describe Molecular::CampaignsController, type: :controller do
  routes { Molecular::Engine.routes }

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
