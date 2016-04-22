Rails.application.routes.draw do
  get 'mandrill/events', to: 'molecular/events#show', as: :mandrill_events
  post 'mandrill/events', to: 'molecular/events#create', as: :create_mandrill_events
end
