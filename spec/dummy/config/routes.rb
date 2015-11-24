Rails.application.routes.draw do
  get 'users', to: 'user#index', as: :molecular_recipients

  mount_molecular campaigns: 'custom_molecular/campaigns'
end
