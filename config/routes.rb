Molecular::Engine.routes.draw do
  resources :campaigns
  resources :events

  root to: 'campaigns#index'
end
