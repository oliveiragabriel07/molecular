require 'spec_helper'
require 'pry-byebug'

module Molecular
  RSpec.describe SubscriptionsController, type: :controller do
    routes { Molecular::Engine.routes }

    let!(:campaign) { create(:campaign) }

    describe "GET #index" do
      it "returns a 200 OK status" do
        get :index, campaign_id: campaign.id
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
