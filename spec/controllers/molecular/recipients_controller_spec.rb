require 'spec_helper'
require 'pry-byebug'

RSpec.describe Molecular::RecipientsController, type: :controller do
  routes { Molecular::Engine.routes }

  let(:campaign) { create(:campaign) }
  let(:users) { create_list(:user, 3) }

  before do
    allow_any_instance_of(Molecular::Campaign).to receive(:recipients).
      and_return(User.where(id: users))
  end

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index, campaign_id: campaign.id
      expect(response).to have_http_status(:ok)
    end

    it "assigns the requested campaign as @campaign" do
      get :index, campaign_id: campaign.id
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "assigns campaign recipients as @recipients" do
      get :index, campaign_id: campaign.id
      expect(assigns(:recipients)).to eq(users)
    end
  end
end
