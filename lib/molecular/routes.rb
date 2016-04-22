module ActionDispatch::Routing
  class Mapper
    def mount_molecular(options = {})
      controllers = Hash.new { |h, k| h[k] = "molecular/#{k}" }
      controllers.merge!(options)

      scope 'molecular' do
        resources :campaigns, controller: controllers[:campaigns] do
          resources :subscriptions, only: :index, controller: controllers[:subscriptions]
          resources :recipients, only: :index, controller: controllers[:recipients]
        end
      end
    end
  end
end
