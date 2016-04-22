require 'resque/server'

Rails.application.routes.draw do
  mount_molecular
  mount Resque::Server, at: '/resque'

  resource :attachments, only: [:new, :create]
  root to: 'custom_molecular/campaigns#index'
end
