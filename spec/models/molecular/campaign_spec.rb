require 'spec_helper'

module Molecular
  describe Campaign do
    let(:campaign) { create(:molecular_campaign) }

    context 'db' do
      context "indexes" do
        it { is_expected.to belong_to(:owner) }
        it { is_expected.to have_many(:subscriptions) }
      end

      context "columns" do
        it { is_expected.to have_db_column(:owner_id).of_type(:integer) }
        it { is_expected.to have_db_column(:owner_type).of_type(:string) }
        it { is_expected.to have_db_column(:subject).of_type(:string) }
        it { is_expected.to have_db_column(:body).of_type(:text) }
        it { is_expected.to have_db_column(:recipients_query).of_type(:string) }
        it { is_expected.to have_db_column(:sent_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:from_name).of_type(:string) }
        it { is_expected.to have_db_column(:from).of_type(:string) }
      end
    end

    context 'validation' do
      it { is_expected.to validate_presence_of(:owner) }
      it { is_expected.to validate_presence_of(:subject) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.not_to allow_value("").for(:body) }
      it { is_expected.to validate_presence_of(:from) }
      it { is_expected.to validate_presence_of(:from_name) }
    end

    context 'factory' do
      it 'has valid factory' do
        expect(build(:molecular_campaign)).to be_valid
      end
    end

    context '#subscribe' do
      let(:recipient) { create(:molecular_recipient) }

      it 'returns subscription' do
        subscription = campaign.subscribe(recipient)
        expect(subscription).not_to be_nil
      end

      it 'creates a new subscription' do
        expect { campaign.subscribe(recipient) }.
          to change(Subscription, :count).by(1)
      end

      context 'existing subscription' do
        let!(:subscription) do
          create(:subscription, campaign: campaign, recipient: recipient)
        end

        it 'return nil' do
          subscription = campaign.subscribe(recipient)
          expect(subscription).to be_nil
        end

        it 'does not create subscription' do
          expect { campaign.subscribe(recipient) }.
            not_to change(Subscription, :count)
        end
      end
    end

    context '#enqueue' do
      it 'add campaign to queue' do
        expect(Molecular::CampaignSenderJob).to receive(:perform_later).
          with(campaign)
        campaign.enqueue
      end

      it 'updates campaing sent_at' do
        expect(campaign.sent_at).to be_nil
        campaign.enqueue
        expect(campaign.sent_at).not_to be_nil
      end
    end

    context '#sent?' do
      it 'returns true if sent_at is not nil' do
        campaign = create(:campaign, sent_at: Time.zone.now)
        expect(campaign.sent?).to eq(true)
      end

      it 'returns false if sent_at is nil' do
        campaign = create(:campaign, sent_at: nil)
        expect(campaign.sent?).to eq(false)
      end
    end

    context '#unique_opens' do
      before do
        create(:subscription, campaign: campaign, opens_count: 3)
        create(:subscription, campaign: campaign, opens_count: 0)
      end

      it 'returns the number of unique opens' do
        expect(campaign.unique_opens).to eq(1)
      end
    end

    context '#unique_clicks' do
      before do
        create(:subscription, campaign: campaign, clicks_count: 3)
        create(:subscription, campaign: campaign, clicks_count: 0)
      end

      it 'returns the number of unique clicks' do
        expect(campaign.unique_clicks).to eq(1)
      end
    end

    context '#open_rate' do
      context 'with opened subscriptions' do
        before do
          create(:subscription, campaign: campaign, opens_count: 2)
          create(:subscription, campaign: campaign, opens_count: 0)
        end

        it 'returns the ratio between unique opens and total subscriptions' do
          expect(campaign.open_rate).to eq 50.to_f
        end
      end

      context 'without opened subscriptions' do
        before do
          create(:subscription, campaign: campaign, opens_count: 0)
        end

        it 'returns zero' do
          expect(campaign.open_rate).to eq 0.to_f
        end
      end

      context 'with no subscriptions' do
        it 'returns zero' do
          expect(campaign.open_rate).to eq 0.to_f
        end
      end
    end

    context '#click_rate' do
      context 'with clicked subscriptions' do
        before do
          create_list(:subscription, 3, campaign: campaign, clicks_count: 2)
          create(:subscription, campaign: campaign, clicks_count: 0)
        end

        it 'returns the ratio between unique clicks and total subscriptions' do
          expect(campaign.click_rate).to eq 75.to_f
        end
      end

      context 'without clicked subscriptions' do
        before do
          create(:subscription, campaign: campaign, clicks_count: 0)
        end

        it 'returns zero' do
          expect(campaign.click_rate).to eq 0.to_f
        end
      end

      context 'with no subscriptions' do
        it 'returns zero' do
          expect(campaign.click_rate).to eq 0.to_f
        end
      end
    end

    context '#total_opens' do
      before do
        create(:subscription, campaign: campaign, opens_count: 2)
        create(:subscription, campaign: campaign, opens_count: 1)
        create(:subscription, campaign: campaign, opens_count: 0)
      end

      it 'returns opens_count sum' do
        expect(campaign.total_opens).to eq(3)
      end
    end

    context '#total_clicks' do
      before do
        create(:subscription, campaign: campaign, clicks_count: 1)
        create(:subscription, campaign: campaign, clicks_count: 1)
        create(:subscription, campaign: campaign, clicks_count: 0)
      end

      it 'returns clicks_count sum' do
        expect(campaign.total_clicks).to eq(2)
      end
    end

    context '#bounces_count' do
      before do
        create_list(:subscription, 2, campaign: campaign, status: :bounced)
        create_list(:subscription, 3, campaign: campaign, status: :soft_bounced)
      end

      it 'returns the number of bounced and soft_bounced subscriptions' do
        expect(campaign.bounces_count).to eq(5)
      end
    end

    context '#rejected_count' do
      before do
        create_list(:subscription, 2, campaign: campaign, status: :rejected)
      end

      it 'returns the number of rejected subscriptions' do
        expect(campaign.rejected_count).to eq(2)
      end
    end

    context '#delivered_count' do
      before do
        create_list(:subscription, 1, campaign: campaign, status: :sent)
      end

      it 'returns the number of sent subscriptions' do
        expect(campaign.delivered_count).to eq(1)
      end
    end

    context '#pending_count' do
      before do
        create_list(:subscription, 5, campaign: campaign, status: :queued)
      end

      it 'returns the number of queued subscriptions' do
        expect(campaign.pending_count).to eq(5)
      end
    end

    context '#last_open' do
      let(:subscription) { create(:subscription, campaign: campaign) }
      let!(:last) do
        create(:event, :open, subscription: subscription,
                              triggered_at: Time.zone.now)
      end
      let!(:previous) do
        create(:event, :open, subscription: subscription,
                              triggered_at: Time.zone.now - 1.hour)
      end

      it 'returns the last open event' do
        expect(campaign.last_open).to eq(last)
      end
    end

    context '#last_click' do
      let(:subscription) { create(:subscription, campaign: campaign) }
      let!(:last) do
        create(:event, :click, subscription: subscription,
                               triggered_at: Time.zone.now)
      end
      let!(:previous) do
        create(:event, :click, subscription: subscription,
                               triggered_at: Time.zone.now - 1.hour)
      end

      it 'returns the last click event' do
        expect(campaign.last_click).to eq(last)
      end
    end
  end
end
