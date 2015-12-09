module Molecular
  # TODO: inherit from main_app mailer
  class Mailer < ActionMailer::Base
    # TODO: definir no initializer
    default from: 'from@example.com'

    def campaign_email(campaign, subscription)
      mail(to: subscription.recipient.email,
           subject: campaign.subject) do |format|
        format.text { render plain: campaign.body }
        format.html { render html: campaign.body.html_safe }
      end

      headers['X-MC-Metadata'] = {subscription_id: subscription.id}.to_json
    end
  end
end
