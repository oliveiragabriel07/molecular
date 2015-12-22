require 'spec_helper'

RSpec.describe Molecular::CampaignsController, type: :controller do
  routes { Molecular::Engine.routes }

  let(:valid_attributes) do
    attributes_for(:campaign)
  end

  let(:invalid_attributes) do
    attributes_for(:campaign, subject: nil)
  end

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "assigns all owner campaigns as @campaign" do
      campaign = create(:campaign, owner: controller.current_user)
      get :index
      expect(assigns(:campaigns)).to eq([campaign])
    end
  end

  describe "GET #new" do
    it "returns a 200 OK status" do
      get :new
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new campaign as @campaign" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Molecular::Campaign)
    end
  end

  describe "GET #show" do
    it "assigns the requested campaigns as @campaigns" do
      campaign = create(:campaign)
      get :show, id: campaign.to_param
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Campaign" do
        expect { post :create, campaign: valid_attributes }.
          to change(Molecular::Campaign, :count).by(1)
      end

      it "assigns a newly created campaign as @campaign" do
        post :create, campaign: valid_attributes
        expect(assigns(:campaign)).to be_a(Molecular::Campaign)
        expect(assigns(:campaign)).to be_persisted
      end

      it "redirects to the created campaign" do
        post :create, campaign: valid_attributes
        expect(response).to redirect_to(Molecular::Campaign.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved campaign as @campaign" do
        post :create, campaign: invalid_attributes
        expect(assigns(:campaign)).to be_a_new(Molecular::Campaign)
      end

      it "re-renders the 'new' template" do
        post :create, campaign: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    let!(:campaign) { create(:campaign) }

    context "with valid params" do
      let(:campaign_subject) { "New subject!" }
      let(:campaign_body) { '<h1>Campaign Title</h1><p>First paragraph</p>' }
      let(:valid_attributes) do
        attributes_for(:campaign, subject: campaign_subject,
                                  body: campaign_body)
      end

      it "locates the requested campaign" do
        put :update, id: campaign.to_param, campaign: valid_attributes
        expect(assigns(:campaign)).to eq(campaign)
      end

      it "updates campaign attributes" do
        put :update, id: campaign.to_param, campaign: valid_attributes
        campaign.reload
        expect(campaign.subject).to eq(campaign_subject)
        expect(campaign.body).to eq(campaign_body)
      end

      it "redirects to the updated campaign" do
        put :update, id: campaign.to_param, campaign: valid_attributes
        expect(response).to redirect_to(campaign)
      end

      # xit 'updates campaing sent_at' do
      #   expect(campaign.sent_at).to be_nil
      #   CampaignSenderJob.perform_now(campaign)
      #   expect(campaign.sent_at).not_to be_nil
      # end
    end

    context "with invalid params" do
      let(:invalid_attributes) do
        attributes_for(:campaign, subject: "", body: "")
      end

      it "locates the requested campaign" do
        put :update, id: campaign.to_param, campaign: invalid_attributes
        expect(assigns(:campaign)).to eq(campaign)
      end

      it "does not change campaign's attributes" do
        put :update, id: campaign.to_param, campaign: invalid_attributes
        campaign.reload
        expect(campaign.subject).not_to eq("")
        expect(campaign.body).not_to eq("")
      end

      it "re-renders the edit method" do
        put :update, id: campaign.to_param, campaign: invalid_attributes
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:campaign) { create(:campaign) }

    it "deletes the campaign" do
      expect { delete :destroy, id: campaign.to_param }
        .to change(Molecular::Campaign, :count).by(-1)
    end

    it "redirects to campaign#index" do
      delete :destroy, id: campaign.to_param
      expect(response).to redirect_to(campaigns_path)
    end
  end
end
