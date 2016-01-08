require_dependency "molecular/application_controller"

module Molecular
  class RecipientsController < ApplicationController
    before_action :load_campaign

    def index
      @recipients = @campaign.recipients.page(params[:page]).per(10)
      respond_to do |format|
        format.html
      end
    end

    private
      def load_campaign
        @campaign = Campaign.find(params[:campaign_id])
      end
  end
end
