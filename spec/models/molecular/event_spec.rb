require 'spec_helper'

module Molecular
  describe Event do
    let(:event) { create(:molecular_event) }

    context 'db' do
      context "indexes" do
        it { is_expected.to belong_to(:subscription) }
      end

      context "columns" do
        it { is_expected.to have_db_column(:subscription_id).of_type(:integer) }
        it { is_expected.to have_db_column(:label).of_type(:string) }
        it { is_expected.to have_db_column(:value).of_type(:string) }
        it { is_expected.to have_db_column(:payload).of_type(:text) }
        it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
        it { is_expected.to have_db_column(:triggered_at).of_type(:datetime) }
      end
    end

    context 'validation' do
      it { is_expected.to validate_presence_of(:subscription) }
    end

    context 'factory' do
      it 'has valid factory' do
        expect(build(:event)).to be_valid
      end

      it 'has open trait' do
        expect(build(:event, :open)).to be_valid
      end

      it 'has click trait' do
        expect(build(:event, :click)).to be_valid
      end
    end

    context '.create_queued' do
      let(:subscription) { create(:subscription) }

      it 'creates a new event' do
        expect { subscription.events.create_queued }.
          to change(Molecular::Event, :count).by(1)
      end

      it 'returns a queued event' do
        event = subscription.events.create_queued
        expect(event.label).to eq('queued')
      end
    end

    context "callbacks" do
      it { is_expected.to callback(:update_counter_cache!).after(:save) }
      it { is_expected.to callback(:update_counter_cache!).after(:destroy) }

      context 'event created' do
        let(:subscription) { create(:subscription) }

        it 'click: updates subscription clicks_count' do
          expect { create(:event, :click, subscription: subscription) }.
            to change(subscription, :clicks_count).by(1)
        end

        it 'open: updates subscription opens_count' do
          expect { create(:event, :open, subscription: subscription) }.
            to change(subscription, :opens_count).by(1)
        end

        it 'other: does not change subscription event counter' do
          expect { create(:event, label: 'sent', subscription: subscription) }.
            not_to change(subscription, :opens_count)
        end
      end
    end
  end
end
