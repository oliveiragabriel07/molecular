require 'resque/server'

Rails.application.routes.draw do
  get 'users', to: 'user#index', as: :molecular_recipients

  mount_molecular campaigns: 'custom_molecular/campaigns'
  mount Resque::Server, at: '/resque'

  resource :attachments, only: [:new, :create]
  root to: 'custom_molecular/campaigns#index'
end
