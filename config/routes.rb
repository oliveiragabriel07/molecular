Molecular::Engine.routes.draw do
  resources :campaigns do
    resources :subscriptions, only: :index
  end
  resource :events, only: [:show, :create]

  root to: 'campaigns#index'
end
