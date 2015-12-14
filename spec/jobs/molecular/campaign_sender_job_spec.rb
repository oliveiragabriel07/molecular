require 'spec_helper'

module Molecular
  RSpec.describe CampaignSenderJob, type: :job do
    include ActiveJob::TestHelper

    let(:campaign) { create(:campaign) }
    let(:users) { create_list(:user, 2) }

    before do
      allow(campaign).to receive(:recipients).and_return(User.where(id: users))
    end

    it 'campaign#enqueue adds campaign to molecular_campaigns queue' do
      assert_enqueued_with job: CampaignSenderJob, args: [campaign],
                           queue: 'molecular_campaigns' do
        campaign.enqueue
      end
    end

    it 'creates new recipients' do
      expect { CampaignSenderJob.perform_now(campaign) }.
        to change(Recipient, :count).by(2)
    end

    context 'with exitings recipient' do
      # OPTIMIZE: create factory recipients_with_emails
      before do
        users.each do |u|
          create(:recipient, email: u.email)
        end
      end

      it 'does not create a new recipient' do
        expect { CampaignSenderJob.perform_now(campaign) }.
          not_to change(Recipient, :count)
      end
    end

    it 'subscribe each recipient' do
      expect(campaign).to receive(:subscribe).exactly(users.count).times
      CampaignSenderJob.perform_now(campaign)
    end

    it 'updates campaing sent_at' do
      expect(campaign.sent_at).to be_nil
      CampaignSenderJob.perform_now(campaign)
      expect(campaign.sent_at).not_to be_nil
    end

    # TODO: check sent_at is not updated
  end
end
