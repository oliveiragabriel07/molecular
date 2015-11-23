module ActionDispatch::Routing
  class Mapper
    def mount_molecular(options = {})
      mod = "molecular"
      controllers = Hash.new { |h, k| h[k] = "#{mod}/#{k}" }
      controllers.merge!(options)

      resources :campaigns, controller: controllers[:campaigns]
    end
  end
end
