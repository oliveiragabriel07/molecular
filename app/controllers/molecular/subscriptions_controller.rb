require_dependency "molecular/application_controller"

module Molecular
  class SubscriptionsController < ApplicationController
    before_action :load_campaign, only: :index

    # GET /campaigns/:id/subscriptions
    def index
      @subscriptions = @campaign.subscriptions.order(updated_at: :desc).
                       page(params[:page]).per(10)
    end

    private
      def load_campaign
        @campaign = Campaign.find(params[:campaign_id])
      end
  end
end
