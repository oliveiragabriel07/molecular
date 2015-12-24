module ActionDispatch::Routing
  class Mapper
    def mount_molecular(options = {})
      controllers = Hash.new { |h, k| h[k] = "molecular/#{k}" }
      controllers.merge!(options)

      resources :campaigns, controller: controllers[:campaigns] do
        resources :subscriptions, only: :index,
                                  controller: controllers[:subscriptions]
      end

      resource :events, controller: controllers[:events],
                        only: [:show, :create]
    end
  end
end
