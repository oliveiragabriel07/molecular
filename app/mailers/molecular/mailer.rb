module Molecular
  class Mailer < ActionMailer::Base
    def campaign_email(id, campaign, recipient)
      mail(headers_for(campaign, recipient)) do |format|
        format.text { render plain: campaign.body }
        format.html { render html: campaign.body.html_safe }
      end

      headers['X-MC-Metadata'] = {subscription_id: id}.to_json
    end

    private
      def headers_for(campaign, recipient)
        {
          to: recipient.email,
          subject: campaign.subject,
          from: mailer_sender(campaign),
          reply_to: campaign.from
        }
      end

      def mailer_sender(campaign)
        if Molecular.mailer_sender.is_a?(Proc)
          Molecular.mailer_sender.call(campaign)
        else
          Molecular.mailer_sender
        end
      end
  end
end
