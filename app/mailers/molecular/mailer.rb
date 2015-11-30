module Molecular
  # TODO: inherit from main_app mailer
  class Mailer < ActionMailer::Base
    default from: 'from@example.com'

    def campaign_email(campaign, list)
      mail(to: list.recipient.email,
           subject: campaign.subject) do |format|
        format.text { render plain: campaign.body }
        format.html { render html: campaign.body.html_safe }
      end

      headers['X-MC-Metadata'] = {list_id: list.id}.to_json
    end
  end
end
