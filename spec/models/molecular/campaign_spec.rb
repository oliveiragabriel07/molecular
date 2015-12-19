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
    end

    context '#sent?' do
      xit 'TODO test sent? method' do
      end
    end

    context '#open_rate' do
      xit 'TODO test sent? method' do
      end
    end

    context '#click_rate' do
      xit 'TODO test sent? method' do
      end
    end

    context '#unique_opens' do
      xit 'TODO test sent? method' do
      end
    end

    context '#unique_clicks' do
      xit 'TODO test sent? method' do
      end
    end
  end
end
