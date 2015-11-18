require 'molecular/routes'

module Molecular
  class Engine < ::Rails::Engine
    isolate_namespace Molecular

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
