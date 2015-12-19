require_dependency "molecular/application_controller"

module Molecular
  class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:show, :edit, :update, :destroy]
    before_action :build_campaign, only: :create

    # GET /campaigns
    def index
      @campaigns = Campaign.where(owner: molecular_owner)
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
      submit and return if params[:submit]

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

    private
      def build_campaign
        @campaign = Campaign.new(campaign_params)
        @campaign.owner = molecular_owner
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_campaign
        @campaign = Campaign.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def campaign_params
        params.
          require(:campaign).
          permit(:subject, :body, :recipients_query, :from, :from_name)
      end

      def submit
        @campaign.enqueue
        redirect_to @campaign, notice: 'Campaign was scheduled'
      end
  end
end
