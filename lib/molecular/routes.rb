module ActionDispatch::Routing
  class Mapper
    def mount_molecular(options = {})
      controllers = Hash.new { |h, k| h[k] = "molecular/#{k}" }
      controllers.merge!(options)

      resources :campaigns, path: 'molecular/campaigns',
                            controller: controllers[:campaigns] do
        resources :subscriptions, only: :index, path: 'molecular/subscriptions',
                                  controller: controllers[:subscriptions]
        resources :recipients, only: :index, path: 'molecular/recipients',
                               controller: controllers[:recipients]
      end

      resource :events, only: [:show, :create], path: 'molecular/events',
                        controller: controllers[:events]
    end
  end
end
