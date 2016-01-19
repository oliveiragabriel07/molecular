Molecular.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Molecular::Mailer
  config.mailer_sender = proc { |campaign|
    "\"#{campaign.from_name} via Molecular\" <member@molecular.com>"
  }
end
