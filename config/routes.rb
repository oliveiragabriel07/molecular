Molecular::Engine.routes.draw do
  resources :campaigns do
    resources :events
  end

  root to: 'campaigns#index'
end
