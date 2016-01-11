Molecular::Engine.routes.draw do
  resources :campaigns, path: 'molecular/campaigns' do
    resources :subscriptions, only: :index, path: 'molecular/subscriptions'
    resources :recipients, only: :index, path: 'molecular/recipients'
  end
  resource :events, only: [:show, :create], path: 'molecular/events'

  root to: 'campaigns#index'
end
