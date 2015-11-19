require_dependency "molecular/application_controller"

module Molecular
  class EventsController < ApplicationController
    before_action :set_event, only: [:show]

    # GET /events
    def index
      @events = Event.all
    end

    # GET /events/1
    def show
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:list_id, :label, :value)
      end
  end
end
