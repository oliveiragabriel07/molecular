require 'spec_helper'

module Molecular
  RSpec.describe EventsController, type: :controller do
    let(:valid_attributes) do
      skip("Add a hash of attributes valid for your model")
    end

    let(:invalid_attributes) do
      skip("Add a hash of attributes invalid for your model")
    end

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # EventsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all events as @events" do
        event = Event.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:events)).to eq([event])
      end
    end

    describe "GET #show" do
      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        get :show, {id: event.to_param}, valid_session
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Event" do
          expect {
            post :create, {event: valid_attributes}, valid_session
          }.to change(Event, :count).by(1)
        end

        it "assigns a newly created event as @event" do
          post :create, {event: valid_attributes}, valid_session
          expect(assigns(:event)).to be_a(Event)
          expect(assigns(:event)).to be_persisted
        end

        it "redirects to the created event" do
          post :create, {event: valid_attributes}, valid_session
          expect(response).to redirect_to(Event.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved event as @event" do
          post :create, {event: invalid_attributes}, valid_session
          expect(assigns(:event)).to be_a_new(Event)
        end

        it "re-renders the 'new' template" do
          post :create, {event: invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end
end
