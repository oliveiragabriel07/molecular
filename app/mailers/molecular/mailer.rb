module Molecular
  # TODO: inherit from main_app mailer
  class Mailer < ActionMailer::Base
    def campaign_email(id, campaign, recipient)
      mail(to: recipient.email, subject: campaign.subject,
           from: "\"#{campaign.from_name}\" <#{campaign.from}>") do |format|
        format.text { render plain: campaign.body }
        format.html { render html: campaign.body.html_safe }
      end

      headers['X-MC-Metadata'] = {subscription_id: id}.to_json
    end
  end
end
