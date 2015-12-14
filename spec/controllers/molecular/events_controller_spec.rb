require 'spec_helper'

module Molecular
  RSpec.describe EventsController, type: :controller do
    routes { Molecular::Engine.routes }

    describe "GET #show" do
      it "returns a 200 OK status" do
        get :show
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST #create" do
      context 'with subscription' do
        let!(:subscription) { create(:subscription) }
        let(:current_time) { Time.zone.now }

        context 'handles open event' do
          let(:mandrill_event) do
            {
              event: "open",
              ts: current_time.to_i,
              msg: {
                state: "sent",
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates open event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("open")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles click event' do
          let(:mandrill_event) do
            {
              event: 'click',
              url: 'https://github.com/oliveiragabriel07/molecular',
              ts: current_time.to_i,
              msg: {
                state: "sent",
                metadata: {subscription_id: subscription.id},
                bounce_description: "general_bounce"
              }
            }
          end

          it 'creates click event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("click")
            expect(event.value).to eq(mandrill_event[:url])
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles spam event' do
          let(:mandrill_event) do
            {
              event: 'spam',
              ts: current_time.to_i,
              msg: {
                state: 'spam',
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates spam event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("spam")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles unsub event' do
          let(:mandrill_event) do
            {
              event: 'unsub',
              ts: current_time.to_i,
              msg: {
                state: 'unsub',
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates unsub event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("unsub")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles reject event' do
          let(:mandrill_event) do
            {
              event: 'reject',
              ts: current_time.to_i,
              msg: {
                state: 'reject',
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates reject event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("reject")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles send event' do
          let(:mandrill_event) do
            {
              event: 'send',
              ts: current_time.to_i,
              msg: {
                state: 'send',
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates send event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("send")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles deferral event' do
          let(:mandrill_event) do
            {
              event: 'deferral',
              ts: current_time.to_i,
              msg: {
                state: 'deferral',
                metadata: {subscription_id: subscription.id}
              }
            }
          end

          it 'creates deferral event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("deferral")
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles hard_bounce event' do
          let(:mandrill_event) do
            {
              event: "hard_bounce",
              ts: current_time.to_i,
              msg: {
                state: "bounced",
                metadata: {subscription_id: subscription.id},
                bounce_description: "bad_mailbox"
              }
            }
          end

          it 'creates hard_bounce event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("hard_bounce")
            expect(event.value).to eq(mandrill_event[:msg][:bounce_description])
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end

        context 'handles soft_bounce event' do
          let(:mandrill_event) do
            {
              event: "soft_bounce",
              ts: current_time.to_i,
              msg: {
                state: "bounced",
                metadata: {subscription_id: subscription.id},
                bounce_description: "general_bounce"
              }
            }
          end

          it 'creates soft_bounce event succesfully' do
            post :create, mandrill_events: [mandrill_event].to_json

            event = Molecular::Event.last
            expect(event.label).to eq("soft_bounce")
            expect(event.value).to eq(mandrill_event[:msg][:bounce_description])
            expect(event.triggered_at.to_s).to eq(current_time.to_s)
          end
        end
      end

      context 'without subscription' do
        xit 'does not create event' do
        end
      end
    end
  end
end
