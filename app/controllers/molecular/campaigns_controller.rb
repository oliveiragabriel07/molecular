require_dependency "molecular/application_controller"

module Molecular
  class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:show, :edit, :update, :destroy]
    before_action :create_campaign, only: :create
    before_action :set_owner, only: :create

    # GET /campaigns
    def index
      @campaigns = Campaign.all
    end

    # GET /campaigns/1
    def show
    end

    # GET /campaigns/new
    def new
      @campaign = Campaign.new
    end

    # GET /campaigns/1/edit
    def edit
    end

    # POST /campaigns
    def create
      if @campaign.save
        redirect_to @campaign, notice: 'Campaign was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /campaigns/1
    def update
      if @campaign.update(campaign_params)
        redirect_to @campaign, notice: 'Campaign was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /campaigns/1
    def destroy
      @campaign.destroy
      redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
    end

    protected
      # This method may be overriden by application to set a different owner
      def set_owner
        @campaign.owner = current_user
      end

    private
      def create_campaign
        @campaign = Campaign.new(campaign_params)
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_campaign
        @campaign = Campaign.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def campaign_params
        params.require(:campaign).permit(:subject, :body, :recipients_query)
      end
  end
end
