require 'test_helper'

module Molecular
  class CampaignsControllerTest < ActionController::TestCase
    setup do
      @campaign = molecular_campaigns(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:campaigns)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create campaign" do
      assert_difference('Campaign.count') do
        post :create, campaign: { body: @campaign.body, owner_id: @campaign.owner_id, owner_type: @campaign.owner_type, recipients_query: @campaign.recipients_query, sent_at: @campaign.sent_at, subject: @campaign.subject }
      end

      assert_redirected_to campaign_path(assigns(:campaign))
    end

    test "should show campaign" do
      get :show, id: @campaign
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @campaign
      assert_response :success
    end

    test "should update campaign" do
      patch :update, id: @campaign, campaign: { body: @campaign.body, owner_id: @campaign.owner_id, owner_type: @campaign.owner_type, recipients_query: @campaign.recipients_query, sent_at: @campaign.sent_at, subject: @campaign.subject }
      assert_redirected_to campaign_path(assigns(:campaign))
    end

    test "should destroy campaign" do
      assert_difference('Campaign.count', -1) do
        delete :destroy, id: @campaign
      end

      assert_redirected_to campaigns_path
    end
  end
end
