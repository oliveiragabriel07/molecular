module Molecular
  class Engine < ::Rails::Engine
    isolate_namespace Molecular

    # Engine.routes.draw do
    #   resources :campaigns
    # end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
