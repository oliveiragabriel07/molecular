require 'spec_helper'

module Molecular
  RSpec.describe Subscription, type: :model do
    context 'db' do
      context "indexes" do
        it { is_expected.to belong_to(:campaign) }
        it { is_expected.to belong_to(:recipient) }
        it { is_expected.to have_many(:events) }
      end

      context "columns" do
        it { is_expected.to have_db_column(:campaign_id).of_type(:integer) }
        it { is_expected.to have_db_column(:recipient_id).of_type(:integer) }
        it { is_expected.to have_db_column(:status).of_type(:integer) }
        it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
      end
    end

    context 'validation' do
      it { is_expected.to validate_presence_of(:campaign) }
      it { is_expected.to validate_presence_of(:recipient) }
    end

    context 'factory' do
      it 'has valid factory' do
        expect(build(:subscription)).to be_valid
      end
    end

    context '#deliver' do
      let(:mail) { double("mail", deliver_now: true) }
      let(:subscription) { create(:subscription) }

      it 'send campaign email' do
        expect(Mailer).to receive(:campaign_email).
          with(subscription.id, subscription.campaign, subscription.recipient).
          and_return(mail)

        subscription.deliver
      end

      it 'creates queued event' do
        expect { subscription.deliver }.to change(Event, :count).by(1)
        expect(subscription.events.last.label).to eq('queued')
      end
    end

    # TODO: check emails is not sent twice
  end
end
