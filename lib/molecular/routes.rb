module ActionDispatch::Routing
  class Mapper
    def mount_molecular(options = {})
      controllers = Hash.new { |h, k| h[k] = "molecular/#{k}" }
      controllers.merge!(options)

      resources :campaigns, controller: controllers[:campaigns] do
        resources :events
      end
    end
  end
end
