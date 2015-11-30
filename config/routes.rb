Molecular::Engine.routes.draw do
  resources :campaigns
  resource :events, only: [:show, :create]

  root to: 'campaigns#index'
end
